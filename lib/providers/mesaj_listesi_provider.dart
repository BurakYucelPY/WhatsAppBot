import 'package:flutter/material.dart';
import '../models/mesaj_model.dart';
import '../database/database.dart';

class MesajListesiProvider extends ChangeNotifier {
  final List<PlanlananMesaj> _mesajlar = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  MesajListesiProvider() {
    loadMesajlar();
  }

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

  Future<void> loadMesajlar() async {
    final mesajlarFromDb = await _dbHelper.getMesajlar();
    _mesajlar
      ..clear()
      ..addAll(mesajlarFromDb);
    notifyListeners();
  }

  Future<void> mesajEkle(PlanlananMesaj mesaj) async {
    await _dbHelper.insertMesaj(mesaj);
    _mesajlar.add(mesaj);
    notifyListeners();
  }

  Future<void> mesajSil(String id) async {
    await _dbHelper.deleteMesaj(id);
    _mesajlar.removeWhere((mesaj) => mesaj.id == id);
    notifyListeners();
  }

  Future<void> gecmisiSifirla() async {
    await _dbHelper.deleteAllMesajlar();
    _mesajlar.clear();
    notifyListeners();
  }

  // Bir gün kala uyarı kontrolü - sadece tarih kontrolü
  List<PlanlananMesaj> get uyariGerekenMesajlar {
    final now = DateTime.now();
    final yarin = DateTime(now.year, now.month, now.day + 1);

    return _mesajlar.where((mesaj) {
      final mesajGunu =
          DateTime(mesaj.tarih.year, mesaj.tarih.month, mesaj.tarih.day);
      final yarinGunu = DateTime(yarin.year, yarin.month, yarin.day);

      // Mesaj yarına planlanmış
      return mesajGunu.isAtSameMomentAs(yarinGunu);
    }).toList();
  }
}
