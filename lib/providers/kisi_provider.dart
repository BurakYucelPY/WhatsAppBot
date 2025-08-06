import 'package:flutter/material.dart';
import '../models/kisi.dart';

class KisiProvider extends ChangeNotifier {
  final List<Kisi> _kisiler = [];

  List<Kisi> get kisiler => List.unmodifiable(_kisiler);

  void kisiEkle(Kisi kisi) {
    _kisiler.add(kisi);
    notifyListeners();
  }

  void kisiSil(String id) {
    _kisiler.removeWhere((kisi) => kisi.id == id);
    notifyListeners();
  }

  int get kisiSayisi => _kisiler.length;
}
