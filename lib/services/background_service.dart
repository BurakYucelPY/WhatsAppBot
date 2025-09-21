import 'package:workmanager/workmanager.dart';
import '../services/whatsapp_api_service.dart';

// Background task'lar için callback fonksiyonu
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "start-python-server":
        // Python server'ını başlat
        print("Background'da Python server başlatılıyor...");
        await WhatsAppApiService.startPythonServer();
        break;

      case "check-server-health":
        // Server'ın çalışıp çalışmadığını kontrol et
        print("Server durumu kontrol ediliyor...");
        bool isRunning = await WhatsAppApiService.isServerRunning();

        if (!isRunning) {
          print("Server çalışmıyor, yeniden başlatılıyor...");
          await WhatsAppApiService.startPythonServer();
        } else {
          print("Server çalışıyor ✓");
        }
        break;

      case "sync-messages":
        // Mesajları senkronize et (opsiyonel)
        print("Mesajlar senkronize ediliyor...");
        await WhatsAppApiService.getScheduledMessages();
        break;
    }

    return Future.value(true);
  });
}

class BackgroundService {
  // Background service'i başlat
  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false, // Release'de false yap
    );

    print("Background service initialize edildi");
  }

  // Python server'ını background'da başlat
  static Future<void> startPythonServerInBackground() async {
    await Workmanager().registerOneOffTask(
      "start-python-server",
      "start-python-server",
      initialDelay: Duration(seconds: 2),
    );

    print("Python server başlatma görevi zamanlandı");
  }

  // Periyodik server health check
  static Future<void> scheduleHealthChecks() async {
    await Workmanager().registerPeriodicTask(
      "health-check-periodic",
      "check-server-health",
      frequency: Duration(minutes: 15), // Her 15 dakikada kontrol et
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );

    print("Periyodik health check zamanlandı");
  }

  // Mesaj senkronizasyonu (opsiyonel)
  static Future<void> scheduleMessageSync() async {
    await Workmanager().registerPeriodicTask(
      "message-sync-periodic",
      "sync-messages",
      frequency: Duration(hours: 1), // Her saatte senkronize et
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );

    print("Mesaj senkronizasyonu zamanlandı");
  }

  // Tüm background task'ları iptal et
  static Future<void> cancelAllTasks() async {
    await Workmanager().cancelAll();
    print("Tüm background task'lar iptal edildi");
  }

  // Belirli bir task'ı iptal et
  static Future<void> cancelTask(String taskName) async {
    await Workmanager().cancelByUniqueName(taskName);
    print("$taskName task'ı iptal edildi");
  }
}
