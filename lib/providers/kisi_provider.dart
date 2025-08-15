import 'package:flutter/material.dart';
import '../models/kisi.dart';
import '../database/database.dart';

class KisiProvider extends ChangeNotifier {
  final List<Kisi> _kisiler = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  KisiProvider() {
    loadKisiler();
  }

  List<Kisi> get kisiler => List.unmodifiable(_kisiler);

  Future<void> loadKisiler() async {
    final kisilerFromDb = await _dbHelper.getKisiler();
    _kisiler
      ..clear()
      ..addAll(kisilerFromDb);
    notifyListeners();
  }

  Future<void> kisiEkle(Kisi kisi) async {
    await _dbHelper.insertKisi(kisi);
    _kisiler.add(kisi);
    notifyListeners();
  }

  Future<void> kisiSil(String id) async {
    await _dbHelper.deleteKisi(id);
    _kisiler.removeWhere((kisi) => kisi.id == id);
    notifyListeners();
  }

  Future<void> rehberiSifirla() async {
    await _dbHelper.deleteAllKisiler();
    _kisiler.clear();
    notifyListeners();
  }

  int get kisiSayisi => _kisiler.length;
}
