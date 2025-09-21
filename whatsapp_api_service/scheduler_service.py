from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from apscheduler.executors.pool import ThreadPoolExecutor
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
import logging
import pytz

from database import ScheduledMessage, MessageStatus, DatabaseManager
from whatsapp_client import WhatsAppCloudClient

logger = logging.getLogger(__name__)

class SchedulerService:
    def __init__(self, db_manager: DatabaseManager, whatsapp_client: WhatsAppCloudClient, database_url: str):
        self.db_manager = db_manager
        self.whatsapp_client = whatsapp_client
        
        # APScheduler konfigürasyonu
        jobstores = {
            'default': SQLAlchemyJobStore(url=database_url, tablename='apscheduler_jobs')
        }
        executors = {
            'default': ThreadPoolExecutor(20)
        }
        job_defaults = {
            'coalesce': False,
            'max_instances': 3
        }
        
        self.scheduler = BackgroundScheduler(
            jobstores=jobstores,
            executors=executors,
            job_defaults=job_defaults,
            timezone=pytz.timezone('Europe/Istanbul')  # Türkiye saat dilimi
        )
    
    def start(self):
        """Scheduler'ı başlat ve mevcut schedule'ları yükle"""
        self.scheduler.start()
        self.reload_schedules()
        logger.info("SchedulerService başlatıldı ve mevcut schedule'lar yüklendi")
    
    def stop(self):
        """Scheduler'ı durdur"""
        self.scheduler.shutdown()
        logger.info("SchedulerService durduruldu")
    
    def add_schedule(self, message: ScheduledMessage):
        """Yeni bir zamanlanmış mesaj ekle"""
        try:
            # Tarih ve saat string'lerini datetime objesine çevir
            schedule_datetime = self._parse_schedule_time(message.tarih, message.saat)
            
            if schedule_datetime <= datetime.now(pytz.timezone('Europe/Istanbul')):
                logger.warning(f"Geçmiş tarihli schedule: {message.id}")
                return False
            
            # APScheduler job'ı ekle
            self.scheduler.add_job(
                func=self._send_scheduled_message,
                trigger='date',
                run_date=schedule_datetime,
                args=[message.id],
                id=message.id,
                replace_existing=True
            )
            
            logger.info(f"Schedule eklendi: {message.id} - {schedule_datetime}")
            return True
            
        except Exception as e:
            logger.error(f"Schedule eklenirken hata: {message.id} - {str(e)}")
            return False
    
    def remove_schedule(self, message_id: str):
        """Zamanlanmış mesajı kaldır"""
        try:
            self.scheduler.remove_job(message_id)
            logger.info(f"Schedule kaldırıldı: {message_id}")
            return True
        except Exception as e:
            logger.error(f"Schedule kaldırılırken hata: {message_id} - {str(e)}")
            return False
    
    def reload_schedules(self):
        """Veritabanından tüm gelecek schedule'ları yükle ve APScheduler'a ekle"""
        try:
            db = next(self.db_manager.get_db())
            
            # Sadece gelecekteki ve queued durumundaki mesajları al
            now = datetime.now(pytz.timezone('Europe/Istanbul'))
            messages = db.query(ScheduledMessage).filter(
                ScheduledMessage.status == MessageStatus.QUEUED
            ).all()
            
            loaded_count = 0
            for message in messages:
                try:
                    schedule_datetime = self._parse_schedule_time(message.tarih, message.saat)
                    if schedule_datetime > now:
                        if self.add_schedule(message):
                            loaded_count += 1
                    else:
                        # Geçmiş tarihliler için status'u FAILED olarak güncelle
                        message.status = MessageStatus.FAILED
                        db.commit()
                except Exception as e:
                    logger.error(f"Schedule yüklenirken hata: {message.id} - {str(e)}")
            
            logger.info(f"{loaded_count} schedule yeniden yüklendi")
            
        except Exception as e:
            logger.error(f"Schedule'lar yüklenirken hata: {str(e)}")
        finally:
            db.close()
    
    def _parse_schedule_time(self, tarih_str: str, saat_str: str) -> datetime:
        """Tarih ve saat string'lerini datetime objesine çevir"""
        # tarih_str: "2024-01-15" formatında ISO string
        # saat_str: "14:30" formatında
        
        tarih_date = datetime.fromisoformat(tarih_str.replace('Z', '+00:00')).date()
        saat_parts = saat_str.split(':')
        hour = int(saat_parts[0])
        minute = int(saat_parts[1])
        
        # Türkiye saat dilimi ile datetime oluştur
        tz = pytz.timezone('Europe/Istanbul')
        schedule_datetime = tz.localize(datetime.combine(tarih_date, datetime.min.time().replace(hour=hour, minute=minute)))
        
        return schedule_datetime
    
    def _send_scheduled_message(self, message_id: str):
        """Zamanlanmış mesajı gönder (APScheduler job fonksiyonu)"""
        db = next(self.db_manager.get_db())
        
        try:
            # Mesajı veritabanından al
            message = db.query(ScheduledMessage).filter(ScheduledMessage.id == message_id).first()
            
            if not message:
                logger.error(f"Mesaj bulunamadı: {message_id}")
                return
            
            # Status'u SENDING olarak güncelle
            message.status = MessageStatus.SENDING
            db.commit()
            
            logger.info(f"Mesaj gönderiliyor: {message_id} -> {message.alici}")
            
            # WhatsApp'a mesaj gönder (retry logic ile)
            success, error = self.whatsapp_client.send_message_with_retry(
                recipient_phone=message.alici,
                message_text=message.mesaj,
                max_retries=3
            )
            
            # Status'u sonuca göre güncelle
            if success:
                message.status = MessageStatus.SENT
                logger.info(f"Mesaj başarıyla gönderildi: {message_id}")
            else:
                message.status = MessageStatus.FAILED
                logger.error(f"Mesaj gönderilemedi: {message_id} - {error}")
            
            db.commit()
            
        except Exception as e:
            logger.error(f"Mesaj gönderilirken hata: {message_id} - {str(e)}")
            if message:
                message.status = MessageStatus.FAILED
                db.commit()
        finally:
            db.close()