import 'dart:ui';
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
    // Tarih ve saat kontrolü
    if (_modalSecilenTarih == null || _secilenSaat == null) {
      _showThemeDialog(
        context,
        Icons.access_time_rounded,
        'Eksik Bilgi',
        'Lütfen tarih ve saat bilgilerini seçiniz',
        Colors.amber,
      );
      return;
    }

    // Seçilen tarih ve saati birleştir
    final secilenDateTime = DateTime(
      _modalSecilenTarih!.year,
      _modalSecilenTarih!.month,
      _modalSecilenTarih!.day,
      _secilenSaat!.hour,
      _secilenSaat!.minute,
    );

    // Geçmiş tarih kontrolü
    if (secilenDateTime.isBefore(DateTime.now())) {
      _showThemeDialog(
        context,
        Icons.schedule_outlined,
        'Geçersiz Zaman',
        'Geçmiş bir tarihe mesaj planlayamazsınız.\nLütfen gelecek bir tarih seçiniz.',
        Colors.redAccent,
      );
      return;
    }

    // Yeni mesaj oluştur
    final yeniMesaj = PlanlananMesaj(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      alici: _alici.trim().isEmpty ? "Alıcı belirtilmedi" : _alici.trim(),
      tarih: _modalSecilenTarih!,
      saat:
          "${_secilenSaat!.hour.toString().padLeft(2, '0')}:${_secilenSaat!.minute.toString().padLeft(2, '0')}",
      mesaj: _mesaj.trim().isEmpty ? "Mesaj belirtilmedi" : _mesaj.trim(),
      olusturmaTarihi: DateTime.now(),
    );

    // Global mesaj listesine ekle
    Provider.of<MesajListesiProvider>(context, listen: false)
        .mesajEkle(yeniMesaj);

    modalKapat();
  }

  void _showThemeDialog(
    BuildContext context,
    IconData icon,
    String title,
    String message,
    Color accentColor,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: accentColor.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Tamam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
