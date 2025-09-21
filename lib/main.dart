import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'screens/ayarlar/tema/tema.dart';
import 'providers/mesaj_listesi_provider.dart';
import 'providers/kisi_provider.dart';
import 'providers/profil_provider.dart';
import 'services/background_service.dart';
import 'services/whatsapp_api_service.dart';
import 'services/asset_copy_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Background service'i initialize et
  await BackgroundService.initialize();

  // Python server'ını başlat
  await initializeWhatsAppService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MesajListesiProvider()),
        ChangeNotifierProvider(create: (_) => KisiProvider()),
        ChangeNotifierProvider(create: (_) => ProfilProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// WhatsApp servisini başlat
Future<void> initializeWhatsAppService() async {
  print("WhatsApp servisi baslatiliyor...");

  // Ilk kurulumu kontrol et
  bool isSetupComplete = await AssetCopyService.isPythonSetupComplete();

  if (!isSetupComplete) {
    print("Ilk kurulum gerekli, Python dosyalari kopyalaniyor...");
    await AssetCopyService.performInitialSetup();
  }

  // Önce direkt baslatmayi dene
  bool isStarted = await WhatsAppApiService.startPythonServer();

  if (isStarted) {
    print("Python server basariyla baslatildi");
  } else {
    print("Python server baslatilamadi, background'da deneniyor...");
    // Background'da baslat
    await BackgroundService.startPythonServerInBackground();
  }

  // Periyodik health checkleri baslat
  await BackgroundService.scheduleHealthChecks();

  // Mesaj senkronizasyonunu baslat
  await BackgroundService.scheduleMessageSync();

  print("WhatsApp servisi konfigurasyonu tamamlandi!");
}
