import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kisi_ekle_view.dart';

class KisiEkleProvider extends ChangeNotifier {
  String _isim = '';
  String _soyisim = '';
  String _telefon = '';
  String _eposta = '';
  String _sirket = '';
  String _selectedCountryCode = '+90';

  String get isim => _isim;
  String get soyisim => _soyisim;
  String get telefon => _telefon;
  String get eposta => _eposta;
  String get sirket => _sirket;
  String get selectedCountryCode => _selectedCountryCode;

  final List<Map<String, String>> countryCodes = [
    {'code': '+90', 'country': 'TR', 'name': 'Türkiye'},
    {'code': '+1', 'country': 'US', 'name': 'ABD'},
    {'code': '+44', 'country': 'GB', 'name': 'İngiltere'},
    {'code': '+49', 'country': 'DE', 'name': 'Almanya'},
    {'code': '+33', 'country': 'FR', 'name': 'Fransa'},
    {'code': '+39', 'country': 'IT', 'name': 'İtalya'},
    {'code': '+34', 'country': 'ES', 'name': 'İspanya'},
    {'code': '+31', 'country': 'NL', 'name': 'Hollanda'},
    {'code': '+7', 'country': 'RU', 'name': 'Rusya'},
    {'code': '+86', 'country': 'CN', 'name': 'Çin'},
  ];

  void setIsim(String value) {
    _isim = value;
    notifyListeners();
  }

  void setSoyisim(String value) {
    _soyisim = value;
    notifyListeners();
  }

  void setTelefon(String value) {
    _telefon = value;
    notifyListeners();
  }

  void setEposta(String value) {
    _eposta = value;
    notifyListeners();
  }

  void setSirket(String value) {
    _sirket = value;
    notifyListeners();
  }

  void setCountryCode(String code) {
    _selectedCountryCode = code;
    notifyListeners();
  }

  bool get isFormValid {
    return _isim.trim().isNotEmpty &&
        _soyisim.trim().isNotEmpty &&
        _telefon.trim().isNotEmpty;
  }

  void kaydet(BuildContext context) {}

  void resetFields() {
    _isim = '';
    _soyisim = '';
    _telefon = '';
    _eposta = '';
    _sirket = '';
    _selectedCountryCode = '+90';
    notifyListeners();
  }
}

class KisiEkleScreen extends StatefulWidget {
  const KisiEkleScreen({super.key});

  @override
  State<KisiEkleScreen> createState() => _KisiEkleScreenState();
}

class _KisiEkleScreenState extends State<KisiEkleScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KisiEkleProvider(),
      child: const KisiEkleView(),
    );
  }
}
