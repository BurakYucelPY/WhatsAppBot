import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class AssetCopyService {
  // Python dosyalarını assets'den app directory'ye kopyala
  static Future<void> copyPythonScriptsToAppDirectory() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final targetDir = Directory('${appDir.path}/whatsapp_api_service');

      // Hedef klasörü oluştur
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
        print('WhatsApp API service klasörü oluşturuldu: ${targetDir.path}');
      }

      // Kopyalanacak dosyalar listesi
      final filesToCopy = [
        'main.py',
        'database.py',
        'schemas.py',
        'whatsapp_client.py',
        'scheduler_service.py',
        'auth.py',
        'requirements.txt',
        '.env',
      ];

      // Her dosyayı kopyala
      for (String fileName in filesToCopy) {
        try {
          // Asset'ten dosyayı oku
          final assetPath = 'assets/python_scripts/$fileName';
          final fileContent = await rootBundle.loadString(assetPath);

          // App directory'ye yaz
          final targetFile = File('${targetDir.path}/$fileName');
          await targetFile.writeAsString(fileContent);

          print('✓ $fileName kopyalandı');
        } catch (e) {
          print('✗ $fileName kopyalanırken hata: $e');
        }
      }

      print('Python scriptleri basariyla kopyalandi!');
    } catch (e) {
      print('Python scriptleri kopyalanirken genel hata: $e');
    }
  }

  // Python paketlerini yükle
  static Future<bool> installPythonPackages() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final scriptDir = '${appDir.path}/whatsapp_api_service';

      print('Python paketleri yukleniyor...');

      // pip install komutunu calistir
      final result = await Process.run(
        'pip',
        ['install', '-r', 'requirements.txt'],
        workingDirectory: scriptDir,
      );

      if (result.exitCode == 0) {
        print('Python paketleri basariyla yuklendi');
        return true;
      } else {
        print('Python paket yukleme hatasi: ${result.stderr}');
        return false;
      }
    } catch (e) {
      print('Python paketleri yuklenirken hata: $e');
      return false;
    }
  }

  // Kurulum durumunu kontrol et
  static Future<bool> isPythonSetupComplete() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final mainPyFile = File('${appDir.path}/whatsapp_api_service/main.py');

      return await mainPyFile.exists();
    } catch (e) {
      return false;
    }
  }

  // İlk kurulumu yap
  static Future<bool> performInitialSetup() async {
    print('Ilk kurulum baslatiliyor...');

    // Python scriptlerini kopyala
    await copyPythonScriptsToAppDirectory();

    // Python paketlerini yukle
    bool packagesInstalled = await installPythonPackages();

    if (packagesInstalled) {
      print('Ilk kurulum basariyla tamamlandi!');
      return true;
    } else {
      print('Ilk kurulum sirasinda hata olustu');
      return false;
    }
  }
}
