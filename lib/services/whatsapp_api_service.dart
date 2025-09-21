import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/mesaj_model.dart';
import 'dart:convert';

class WhatsAppApiService {
  static const String baseUrl = 'http://localhost:8000';
  static const String apiKey = 'your_super_secret_api_key_here_change_this';
  static Process? _pythonProcess;

  // Python server'ını başlat
  static Future<bool> startPythonServer() async {
    try {
      // Uygulama dizinini al
      final appDir = await getApplicationDocumentsDirectory();
      final pythonScriptPath = '${appDir.path}/whatsapp_api_service';

      // Python server'ını başlat
      _pythonProcess = await Process.start(
        'python',
        ['main.py'],
        workingDirectory: pythonScriptPath,
        mode: ProcessStartMode.detached,
      );

      print('Python server başlatıldı: PID ${_pythonProcess?.pid}');

      // Server'ın başlamasını bekle (3 saniye)
      await Future.delayed(Duration(seconds: 3));

      // Health check
      return await isServerRunning();
    } catch (e) {
      print('Python server başlatılırken hata: $e');
      return false;
    }
  }

  // Server çalışıyor mu kontrol et
  static Future<bool> isServerRunning() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'X-API-Key': apiKey},
      ).timeout(Duration(seconds: 2));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Zamanlanmış mesaj oluştur
  static Future<bool> createScheduledMessage(PlanlananMesaj mesaj) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/schedule'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key': apiKey,
        },
        body: json.encode(mesaj.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Mesaj oluşturulurken hata: $e');
      return false;
    }
  }

  // Tüm zamanlanmış mesajları getir
  static Future<List<PlanlananMesaj>> getScheduledMessages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/schedule'),
        headers: {'X-API-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => PlanlananMesaj.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Mesajlar getirilirken hata: $e');
      return [];
    }
  }

  // Zamanlanmış mesajı sil
  static Future<bool> deleteScheduledMessage(String messageId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/schedule/$messageId'),
        headers: {'X-API-Key': apiKey},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Mesaj silinirken hata: $e');
      return false;
    }
  }

  // Mesaj durumunu kontrol et
  static Future<String?> getMessageStatus(String messageId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/status/$messageId'),
        headers: {'X-API-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['status'];
      }
      return null;
    } catch (e) {
      print('Mesaj durumu kontrol edilirken hata: $e');
      return null;
    }
  }

  // Python server'ını durdur
  static void stopPythonServer() {
    _pythonProcess?.kill();
    _pythonProcess = null;
    print('Python server durduruldu');
  }
}
