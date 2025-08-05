import 'package:flutter/material.dart';
import '../models/mesaj_model.dart';

class MesajListesiProvider extends ChangeNotifier {
  final List<PlanlananMesaj> _mesajlar = [];

  List<PlanlananMesaj> get mesajlar {
    final now = DateTime.now();
    return _mesajlar.where((mesaj) {
      final mesajDateTime = DateTime(
        mesaj.tarih.year,
        mesaj.tarih.month,
        mesaj.tarih.day,
        int.parse(mesaj.saat.split(':')[0]),
        int.parse(mesaj.saat.split(':')[1]),
      );
      return mesajDateTime.isAfter(now);
    }).toList();
  }

  List<PlanlananMesaj> get gecmisMesajlar {
    final now = DateTime.now();
    return _mesajlar.where((mesaj) {
      final mesajDateTime = DateTime(
        mesaj.tarih.year,
        mesaj.tarih.month,
        mesaj.tarih.day,
        int.parse(mesaj.saat.split(':')[0]),
        int.parse(mesaj.saat.split(':')[1]),
      );
      return mesajDateTime.isBefore(now) || mesajDateTime.isAtSameMomentAs(now);
    }).toList();
  }

  PlanlananMesaj? get enYakinMesaj {
    if (mesajlar.isEmpty) return null;
    return mesajlar.first;
  }

  void mesajEkle(PlanlananMesaj mesaj) {
    _mesajlar.add(mesaj);
    notifyListeners();
  }
}
