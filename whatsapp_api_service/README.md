# WhatsApp Bot API

Bu proje, WhatsApp Cloud API kullanarak zamanlanmış mesaj gönderme servisini sağlar.

## Kurulum

1. Gerekli paketleri yükleyin:
```bash
pip install -r requirements.txt
```

2. `.env` dosyasını oluşturun:
```bash
cp .env.example .env
```

3. `.env` dosyasını düzenleyin ve gerekli değerleri girin:
   - `ACCESS_TOKEN`: WhatsApp Cloud API access token'ınız
   - `PHONE_NUMBER_ID`: WhatsApp Business phone number ID'niz
   - `API_KEY`: API güvenliği için kullanılacak secret key
   - `DATABASE_URL`: SQLite veritabanı URL'i (varsayılan: `sqlite:///./whatsapp_schedules.db`)

## Çalıştırma

```bash
python main.py
```

Servis varsayılan olarak `http://localhost:8000` adresinde çalışacaktır.

## API Endpoints

### Authentication
Tüm endpoint'ler `X-API-Key` header ile authentication gerektirir.

### POST /schedule
Yeni zamanlanmış mesaj oluşturur.

**Request Body:**
```json
{
    "id": "unique-message-id",
    "alici": "905551234567",
    "tarih": "2024-01-15",
    "saat": "14:30",
    "mesaj": "Merhaba! Bu zamanlanmış bir mesajdır.",
    "olusturmaTarihi": "2024-01-10T10:00:00Z"
}
```

### GET /schedule
Gelecekteki tüm zamanlanmış mesajları listeler.

### DELETE /schedule/{id}
Belirtilen ID'ye sahip zamanlanmış mesajı siler.

### GET /status/{id}
Mesajın gönderim durumunu döner.

**Response:**
```json
{
    "id": "message-id",
    "status": "queued|sending|sent|failed"
}
```

### GET /health
Servis sağlık kontrolü.

## Özellikler

- ✅ SQLite veritabanı ile mesaj saklama
- ✅ APScheduler ile zamanlanmış görev yönetimi
- ✅ WhatsApp Cloud API entegrasyonu
- ✅ Retry logic (5xx hatalar için exponential backoff)
- ✅ API key authentication
- ✅ Startup'ta mevcut schedule'ların yeniden yüklenmesi
- ✅ Türkiye saat dilimi desteği

## Mesaj Durumları

- `queued`: Mesaj kuyruğa alınmış, henüz gönderilmemiş
- `sending`: Mesaj şu anda gönderiliyor
- `sent`: Mesaj başarıyla gönderildi
- `failed`: Mesaj gönderilemedi

## Örnek Kullanım

```bash
# Yeni mesaj zamanla
curl -X POST "http://localhost:8000/schedule" \
  -H "X-API-Key: your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "msg-001",
    "alici": "905551234567",
    "tarih": "2024-01-15",
    "saat": "14:30",
    "mesaj": "Test mesajı"
  }'

# Mesaj durumunu kontrol et
curl -X GET "http://localhost:8000/status/msg-001" \
  -H "X-API-Key: your-api-key"
```