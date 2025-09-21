from sqlalchemy import create_engine, Column, String, DateTime, Enum
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import func
import enum
from datetime import datetime

Base = declarative_base()

class MessageStatus(str, enum.Enum):
    QUEUED = "queued"
    SENDING = "sending"
    SENT = "sent"
    FAILED = "failed"

class ScheduledMessage(Base):
    __tablename__ = "scheduled_messages"
    
    id = Column(String, primary_key=True, index=True)
    alici = Column(String, nullable=False)  # Alıcı telefon numarası
    tarih = Column(String, nullable=False)  # ISO format tarih
    saat = Column(String, nullable=False)   # HH:MM format
    mesaj = Column(String, nullable=False)  # Mesaj içeriği
    olusturmaTarihi = Column(DateTime, default=func.now())
    status = Column(Enum(MessageStatus), default=MessageStatus.QUEUED)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

class DatabaseManager:
    def __init__(self, database_url: str):
        self.engine = create_engine(database_url, connect_args={"check_same_thread": False})
        self.SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=self.engine)
        Base.metadata.create_all(bind=self.engine)
    
    def get_db(self):
        db = self.SessionLocal()
        try:
            yield db
        finally:
            db.close()