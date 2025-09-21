# 🚀 WhatsApp Bot API - Otomatik Mesaj Servisi

Bu proje, WhatsApp Cloud API kullanarak zamanlanmış mesaj gönderme servisini sağlar. Flutter uygulaması ile entegre edilmiş olup, SQLite veritabanında mesajları saklar ve APScheduler ile otomatik gönderim yapar.

## 📋 Özellikler

- ✅ **Zamanlanmış Mesaj Gönderimi** - Belirtilen tarih/saatte otomatik mesaj
- ✅ **WhatsApp Cloud API Entegrasyonu** - Resmi WhatsApp Business API
- ✅ **SQLite Veritabanı** - Mesaj saklama ve durum takibi
- ✅ **APScheduler** - Güvenilir job scheduling sistemi
- ✅ **Retry Logic** - 5xx hatalar için exponential backoff
- ✅ **API Authentication** - X-API-Key header ile güvenlik
- ✅ **Auto-reload** - Sistem yeniden başlatıldığında schedule'ları yükler
- ✅ **Türkiye Saat Dilimi** - Europe/Istanbul timezone desteği

## 🛠️ Kurulum

### 1. Gereksinimler
- Python 3.8+
- WhatsApp Business hesabı
- Meta Developer hesabı

### 2. Paket Kurulumu
```bash
cd whatsapp_api_service
python -m venv .venv

# Windows
.venv\Scripts\activate

# Linux/Mac  
source .venv/bin/activate

pip install -r requirements.txt
```

### 3. WhatsApp Cloud API Kurulumu

#### 3.1 Meta Developer Hesabı
1. [Meta Developer Console](https://developers.facebook.com/apps/) 'a git
2. **"Create App"** → **"Business"** seç
3. **"WhatsApp"** ürününü ekle

#### 3.2 WhatsApp Business Hesabı
1. WhatsApp Business Manager'da telefon numarası ekle
2. **Phone Number ID** kopyala
3. **Access Token** oluştur (Permanent token önerilir)

### 4. Konfigürasyon

`.env` dosyasını düzenle:
```bash
# Meta Developer Console'dan alınan token
ACCESS_TOKEN=EAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# WhatsApp Business telefon numarası ID'si  
PHONE_NUMBER_ID=1234567890123456

# API güvenliği için güçlü şifre
API_KEY=your-super-secret-api-key-here-change-this

# Veritabanı dosyası
DATABASE_URL=sqlite:///./whatsapp_schedules.db
```

**⚠️ ÖNEMLİ:** `.env` dosyasını asla Git'e push etme!

## 🚀 Çalıştırma

```bash
python main.py
```

Server başlar: `http://localhost:8000`

API dokümantasyonu: `http://localhost:8000/docs`

## 📡 API Endpoints

Tüm endpoint'ler **X-API-Key** header gerektirir:
```bash
X-API-Key: your-super-secret-api-key-here-change-this
```

### POST /schedule
Yeni zamanlanmış mesaj oluştur

**Request Body:**
```json
{
    "id": "msg-001",
    "alici": "+905551234567", 
    "tarih": "2025-09-22",
    "saat": "14:30",
    "mesaj": "Merhaba! Bu zamanlanmış bir mesajdır.",
    "olusturmaTarihi": "2025-09-21T10:00:00Z"
}
```

**Response:**
```json
{
    "id": "msg-001",
    "alici": "+905551234567",
    "tarih": "2025-09-22", 
    "saat": "14:30",
    "mesaj": "Merhaba! Bu zamanlanmış bir mesajdır.",
    "status": "queued",
    "created_at": "2025-09-21T10:00:00Z"
}
```

### GET /schedule
Gelecekteki tüm zamanlanmış mesajları listele

### DELETE /schedule/{id}
Belirtilen mesajı iptal et ve sil

### GET /status/{id}
Mesaj gönderim durumunu öğren

**Response:**
```json
{
    "id": "msg-001",
    "status": "sent"  // queued, sending, sent, failed
}
```

### GET /health
Servis sağlık kontrolü

## 📱 Flutter Entegrasyonu

Flutter uygulamasından API'yi kullanmak için:

```dart
// HTTP isteği örneği
final response = await http.post(
  Uri.parse('http://localhost:8000/schedule'),
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': 'your-api-key',
  },
  body: json.encode({
    'id': 'msg-${DateTime.now().millisecondsSinceEpoch}',
    'alici': '+905551234567',
    'tarih': '2025-09-22', 
    'saat': '14:30',
    'mesaj': 'Test mesajı',
    'olusturmaTarihi': DateTime.now().toIso8601String(),
  }),
);
```

## 🔄 Sistem Akışı

1. **Flutter App** → POST `/schedule` → **Python API**
2. **Python API** → Mesajı **SQLite**'a kaydet
3. **APScheduler** → Job oluştur (tarih/saat için)  
4. **Zamanı geldiğinde** → **WhatsApp Cloud API**'ye gönder
5. **Status güncelle** → `sent` veya `failed`

## 📊 Mesaj Durumları

- **`queued`** - Kuyruğa alındı, henüz gönderilmedi
- **`sending`** - Şu anda gönderiliyor  
- **`sent`** - Başarıyla gönderildi
- **`failed`** - Gönderim başarısız (3 deneme sonrası)

## 🔒 Güvenlik

- API Key authentication ile erişim kontrolü
- Environment variables ile hassas bilgi yönetimi
- SQLite injection korunması
- Rate limiting (gerekirse eklenebilir)

## 🐛 Troubleshooting

### WhatsApp API Hataları
- **401 Unauthorized** - ACCESS_TOKEN yanlış
- **404 Not Found** - PHONE_NUMBER_ID yanlış  
- **403 Forbidden** - Telefon numarası doğrulanmamış
- **429 Rate Limited** - Çok fazla istek gönderildi

### Yaygın Sorunlar
```bash
# Paketler yüklenmemişse
pip install -r requirements.txt

# Port kullanımda ise
python main.py --port 8001

# Database hatası
rm whatsapp_schedules.db  # Veritabanını sıfırla
```

## 📈 Production Kurulumu

### Docker ile
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "main.py"]
```

### Nginx ile
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
    }
}
```

## 📞 İletişim

- GitHub: [@BurakYucelPY](https://github.com/BurakYucelPY)
- Repository: [WhatsApp Bot](https://github.com/BurakYucelPY/WhatsAppBot)
