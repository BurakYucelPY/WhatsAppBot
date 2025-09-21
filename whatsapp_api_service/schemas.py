from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from database import MessageStatus

class MessageCreate(BaseModel):
    id: str
    alici: str  # Telefon numarası
    tarih: str  # ISO format tarih string'i
    saat: str   # HH:MM format
    mesaj: str  # Mesaj içeriği
    olusturmaTarihi: str  # ISO format tarih string'i

class MessageResponse(BaseModel):
    id: str
    alici: str
    tarih: str
    saat: str
    mesaj: str
    olusturmaTarihi: str
    status: MessageStatus
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

class MessageStatusResponse(BaseModel):
    id: str
    status: MessageStatus