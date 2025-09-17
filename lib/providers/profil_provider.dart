import 'package:flutter/material.dart';

class ProfilProvider extends ChangeNotifier {
  String _kullaniciAdi = 'Kullanıcı Adı';
  String _telefon = '+90 555 123 45 67';
  String _eposta = 'kullanici@example.com';
  String _hakkinda = 'WhatsApp Bot kullanıcısı';
  bool _bildirimlerAktif = true;
  bool _cevirimiciDurumGoster = true;
  bool _sonGorulemeBilgisiGoster = true;

  // Getters
  String get kullaniciAdi => _kullaniciAdi;
  String get telefon => _telefon;
  String get eposta => _eposta;
  String get hakkinda => _hakkinda;
  bool get bildirimlerAktif => _bildirimlerAktif;
  bool get cevirimiciDurumGoster => _cevirimiciDurumGoster;
  bool get sonGorulemeBilgisiGoster => _sonGorulemeBilgisiGoster;

  // Profil bilgilerini güncelleme
  void kullaniciAdiniGuncelle(String yeniAd) {
    _kullaniciAdi = yeniAd;
    notifyListeners();
  }

  void telefonGuncelle(String yeniTelefon) {
    _telefon = yeniTelefon;
    notifyListeners();
  }

  void epostaGuncelle(String yeniEposta) {
    _eposta = yeniEposta;
    notifyListeners();
  }

  void hakkindaGuncelle(String yeniHakkinda) {
    _hakkinda = yeniHakkinda;
    notifyListeners();
  }

  // Gizlilik ayarları
  void bildirimleriDegistir(bool deger) {
    _bildirimlerAktif = deger;
    notifyListeners();
  }

  void cevirimiciDurumunuDegistir(bool deger) {
    _cevirimiciDurumGoster = deger;
    notifyListeners();
  }

  void sonGorulemeBilgisiniDegistir(bool deger) {
    _sonGorulemeBilgisiGoster = deger;
    notifyListeners();
  }
}