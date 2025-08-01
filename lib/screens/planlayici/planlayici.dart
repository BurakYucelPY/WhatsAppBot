import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/planlayici/planlayici_view.dart';

class PlanlayiciProvider extends ChangeNotifier {
  bool _modalGorunur = false;
  DateTime? _secilenTarih;
  TimeOfDay? _secilenSaat;
  String _alici = '';
  String _mesaj = '';

  bool get modalGorunur => _modalGorunur;
  DateTime? get secilenTarih => _secilenTarih;
  TimeOfDay? get secilenSaat => _secilenSaat;
  String get alici => _alici;
  String get mesaj => _mesaj;

  void modalAc() {
    _modalGorunur = true;
    notifyListeners();
  }

  void modalKapat() {
    _modalGorunur = false;
    _secilenTarih = null;
    _secilenSaat = null;
    _alici = '';
    _mesaj = '';
    notifyListeners();
  }

  void tarihAyarla(DateTime tarih) {
    _secilenTarih = tarih;
    notifyListeners();
  }

  void saatAyarla(TimeOfDay saat) {
    _secilenSaat = saat;
    notifyListeners();
  }

  void aliciAyarla(String alici) {
    _alici = alici;
    notifyListeners();
  }

  void mesajAyarla(String mesaj) {
    _mesaj = mesaj;
    notifyListeners();
  }

  void mesajPlanla() {
    modalKapat();
  }
}

class PlanlayiciScreen extends StatefulWidget {
  const PlanlayiciScreen({super.key});

  @override
  State<PlanlayiciScreen> createState() => _PlanlayiciScreenState();
}

class _PlanlayiciScreenState extends State<PlanlayiciScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlanlayiciProvider(),
      child: const PlanlayiciView(),
    );
  }
}
