from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import os
from dotenv import load_dotenv
import logging
from contextlib import asynccontextmanager

from database import DatabaseManager, ScheduledMessage, MessageStatus
from schemas import MessageCreate, MessageResponse, MessageStatusResponse
from whatsapp_client import WhatsAppCloudClient
from scheduler_service import SchedulerService
from auth import verify_api_key_header

# Environment variables yükle
load_dotenv()

# Logging konfigürasyonu
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Global değişkenler
db_manager = None
whatsapp_client = None
scheduler_service = None

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Uygulama lifecycle yönetimi"""
    global db_manager, whatsapp_client, scheduler_service
    
    # Startup
    # Environment variables kontrolü
    required_env_vars = ["ACCESS_TOKEN", "PHONE_NUMBER_ID", "API_KEY", "DATABASE_URL"]
    missing_vars = [var for var in required_env_vars if not os.getenv(var)]
    
    if missing_vars:
        raise ValueError(f"Missing environment variables: {', '.join(missing_vars)}")
    
    # Database manager
    database_url = os.getenv("DATABASE_URL", "sqlite:///./whatsapp_schedules.db")
    db_manager = DatabaseManager(database_url)
    
    # WhatsApp client
    whatsapp_client = WhatsAppCloudClient(
        access_token=os.getenv("ACCESS_TOKEN"),
        phone_number_id=os.getenv("PHONE_NUMBER_ID")
    )
    
    # Scheduler service
    scheduler_service = SchedulerService(db_manager, whatsapp_client, database_url)
    scheduler_service.start()
    
    logger.info("WhatsApp Bot API başlatıldı")
    
    yield
    
    # Shutdown
    if scheduler_service:
        scheduler_service.stop()
    logger.info("WhatsApp Bot API kapatıldı")

# FastAPI uygulaması
app = FastAPI(
    title="WhatsApp Bot API",
    description="WhatsApp mesaj zamanlayıcı ve gönderme servisi",
    version="1.0.0",
    lifespan=lifespan
)

# Dependency functions
def get_db():
    return next(db_manager.get_db())

@app.post("/schedule", response_model=MessageResponse)
async def create_schedule(
    message: MessageCreate,
    db: Session = Depends(get_db),
    _: str = Depends(verify_api_key_header)
):
    """
    Yeni zamanlanmış mesaj oluştur
    """
    try:
        # Veritabanına kaydet
        db_message = ScheduledMessage(
            id=message.id,
            alici=message.alici,
            tarih=message.tarih,
            saat=message.saat,
            mesaj=message.mesaj,
            olusturmaTarihi=message.olusturmaTarihi,
            status=MessageStatus.QUEUED
        )
        
        db.add(db_message)
        db.commit()
        db.refresh(db_message)
        
        # Scheduler'a ekle
        success = scheduler_service.add_schedule(db_message)
        if not success:
            db_message.status = MessageStatus.FAILED
            db.commit()
            db.refresh(db_message)
        
        return MessageResponse.from_orm(db_message)
        
    except Exception as e:
        logger.error(f"Schedule oluşturulurken hata: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")

@app.get("/schedule", response_model=List[MessageResponse])
async def get_schedules(
    db: Session = Depends(get_db),
    _: str = Depends(verify_api_key_header)
):
    """
    Gelecekteki tüm zamanlanmış mesajları getir
    """
    try:
        # Sadece QUEUED durumundaki mesajları getir
        messages = db.query(ScheduledMessage).filter(
            ScheduledMessage.status == MessageStatus.QUEUED
        ).all()
        
        return [MessageResponse.from_orm(message) for message in messages]
        
    except Exception as e:
        logger.error(f"Schedule'lar getirilirken hata: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")

@app.delete("/schedule/{message_id}")
async def delete_schedule(
    message_id: str,
    db: Session = Depends(get_db),
    _: str = Depends(verify_api_key_header)
):
    """
    Zamanlanmış mesajı sil
    """
    try:
        # Veritabanından mesajı bul
        db_message = db.query(ScheduledMessage).filter(ScheduledMessage.id == message_id).first()
        
        if not db_message:
            raise HTTPException(status_code=404, detail="Schedule not found")
        
        # Scheduler'dan kaldır
        scheduler_service.remove_schedule(message_id)
        
        # Veritabanından sil
        db.delete(db_message)
        db.commit()
        
        return {"message": f"Schedule {message_id} deleted successfully"}
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Schedule silinirken hata: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")

@app.get("/status/{message_id}", response_model=MessageStatusResponse)
async def get_message_status(
    message_id: str,
    db: Session = Depends(get_db),
    _: str = Depends(verify_api_key_header)
):
    """
    Mesaj gönderim durumunu getir
    """
    try:
        db_message = db.query(ScheduledMessage).filter(ScheduledMessage.id == message_id).first()
        
        if not db_message:
            raise HTTPException(status_code=404, detail="Message not found")
        
        return MessageStatusResponse(id=db_message.id, status=db_message.status)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Status getirilirken hata: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")

@app.get("/health")
async def health_check():
    """
    Servis sağlık kontrolü
    """
    return {
        "status": "healthy",
        "service": "WhatsApp Bot API",
        "scheduler_running": scheduler_service.scheduler.running if scheduler_service else False
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)