import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/planlayici/planlayici_view.dart';
import '../../models/mesaj_model.dart';
import '../../providers/mesaj_listesi_provider.dart';

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

  void mesajPlanla(BuildContext context) {
    // Yeni mesaj oluştur
    final yeniMesaj = PlanlananMesaj(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      alici: _alici.trim().isEmpty ? "Alıcı belirtilmedi" : _alici.trim(),
      tarih: _secilenTarih ?? DateTime.now(),
      saat: _secilenSaat != null
          ? "${_secilenSaat!.hour.toString().padLeft(2, '0')}:${_secilenSaat!.minute.toString().padLeft(2, '0')}"
          : "00:00",
      mesaj: _mesaj.trim().isEmpty ? "Mesaj belirtilmedi" : _mesaj.trim(),
      olusturmaTarihi: DateTime.now(),
    );

    // Global mesaj listesine ekle
    Provider.of<MesajListesiProvider>(context, listen: false)
        .mesajEkle(yeniMesaj);

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
