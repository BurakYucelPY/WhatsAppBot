import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'anasayfa_view.dart';
import '../../models/mesaj_model.dart';
import '../../providers/mesaj_listesi_provider.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  bool _modalGorunur = false;
  DateTime? _modalSecilenTarih;
  TimeOfDay? _secilenSaat;
  String _alici = '';
  String _mesaj = '';

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  bool get modalGorunur => _modalGorunur;
  DateTime? get modalSecilenTarih => _modalSecilenTarih;
  TimeOfDay? get secilenSaat => _secilenSaat;
  String get alici => _alici;
  String get mesaj => _mesaj;

  void gunSec(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;

    _modalSecilenTarih = selectedDay;
    _modalGorunur = true;

    notifyListeners();
  }

  void formatDegistir(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  void modalKapat() {
    _modalGorunur = false;
    _secilenSaat = null;
    _alici = '';
    _mesaj = '';
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
      tarih: _modalSecilenTarih ?? DateTime.now(),
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

class AnasayfaScreen extends StatefulWidget {
  const AnasayfaScreen({super.key});

  @override
  State<AnasayfaScreen> createState() => _AnasayfaScreenState();
}

class _AnasayfaScreenState extends State<AnasayfaScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarProvider(),
      child: const AnasayfaView(),
    );
  }
}
