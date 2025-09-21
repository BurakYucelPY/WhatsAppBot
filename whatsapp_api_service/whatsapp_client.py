import requests
import time
import logging
from typing import Optional

logger = logging.getLogger(__name__)

class WhatsAppCloudClient:
    def __init__(self, access_token: str, phone_number_id: str):
        self.access_token = access_token
        self.phone_number_id = phone_number_id
        self.base_url = f"https://graph.facebook.com/v17.0/{phone_number_id}/messages"
        
    def send_message(self, recipient_phone: str, message_text: str) -> tuple[bool, Optional[str]]:
        """
        WhatsApp Cloud API ile mesaj gönder
        
        Args:
            recipient_phone: Alıcının telefon numarası (90xxxxxxxxxx formatında)
            message_text: Gönderilecek mesaj metni
            
        Returns:
            tuple[bool, Optional[str]]: (başarı_durumu, hata_mesajı)
        """
        headers = {
            "Authorization": f"Bearer {self.access_token}",
            "Content-Type": "application/json"
        }
        
        payload = {
            "messaging_product": "whatsapp",
            "to": recipient_phone,
            "type": "text",
            "text": {
                "body": message_text
            }
        }
        
        try:
            response = requests.post(
                self.base_url,
                headers=headers,
                json=payload,
                timeout=30
            )
            
            if response.status_code == 200:
                logger.info(f"Mesaj başarıyla gönderildi: {recipient_phone}")
                return True, None
            else:
                error_msg = f"WhatsApp API Error: {response.status_code} - {response.text}"
                logger.error(error_msg)
                return False, error_msg
                
        except requests.exceptions.RequestException as e:
            error_msg = f"Request failed: {str(e)}"
            logger.error(error_msg)
            return False, error_msg
    
    def send_message_with_retry(self, recipient_phone: str, message_text: str, max_retries: int = 3) -> tuple[bool, Optional[str]]:
        """
        Retry logic ile mesaj gönder (5xx hatalar için exponential backoff)
        """
        for attempt in range(max_retries):
            success, error = self.send_message(recipient_phone, message_text)
            
            if success:
                return True, None
                
            # 5xx server hatalarında retry yap
            if error and ("50" in error or "timeout" in error.lower()):
                if attempt < max_retries - 1:  # Son denemede değilse
                    wait_time = (2 ** attempt) * 1  # Exponential backoff: 1, 2, 4 saniye
                    logger.info(f"Retry {attempt + 1}/{max_retries} after {wait_time} seconds")
                    time.sleep(wait_time)
                    continue
            
            # 4xx client hatalarında retry yapma
            return False, error
            
        return False, f"Failed after {max_retries} attempts"