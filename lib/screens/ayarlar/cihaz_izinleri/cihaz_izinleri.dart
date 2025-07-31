import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/ayarlar/cihaz_izinleri/cihaz_izinleri_view.dart';

class CihazIzinleriProvider extends ChangeNotifier {
  bool _bildirim = false;
  bool _kisi = false;
  bool _mikrofon = false;

  bool get bildirim => _bildirim;
  bool get kisi => _kisi;
  bool get mikrofon => _mikrofon;

  void toggleBildirim() {
    _bildirim = !_bildirim;
    notifyListeners();
  }

  void toggleKisi() {
    _kisi = !_kisi;
    notifyListeners();
  }

  void toggleMikrofon() {
    _mikrofon = !_mikrofon;
    notifyListeners();
  }
}

class CihazIzinleriScreen extends StatefulWidget {
  const CihazIzinleriScreen({super.key});

  @override
  State<CihazIzinleriScreen> createState() => _CihazIzinleriScreenState();
}

class _CihazIzinleriScreenState extends State<CihazIzinleriScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CihazIzinleriProvider(),
      child: const CihazIzinleriView(),
    );
  }
}
