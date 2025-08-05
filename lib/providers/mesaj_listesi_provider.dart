import 'package:flutter/material.dart';
import '../models/mesaj_model.dart';

class MesajListesiProvider extends ChangeNotifier {
  final List<PlanlananMesaj> _mesajlar = [];

  List<PlanlananMesaj> get mesajlar => List.unmodifiable(_mesajlar);

  PlanlananMesaj? get enYakinMesaj {
    if (_mesajlar.isEmpty) return null;
    return _mesajlar.first;
  }

  void mesajEkle(PlanlananMesaj mesaj) {
    _mesajlar.add(mesaj);
    notifyListeners();
  }
}
