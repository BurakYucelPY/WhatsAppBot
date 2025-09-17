import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profil_view.dart';
import '../../../providers/profil_provider.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _epostaController = TextEditingController();
  final TextEditingController _hakkindaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllersInitialize();
  }

  void _controllersInitialize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profilProvider =
          Provider.of<ProfilProvider>(context, listen: false);
      _kullaniciAdiController.text = profilProvider.kullaniciAdi;
      _telefonController.text = profilProvider.telefon;
      _epostaController.text = profilProvider.eposta;
      _hakkindaController.text = profilProvider.hakkinda;
    });
  }

  void _kullaniciAdiniGuncelle() {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.kullaniciAdiniGuncelle(_kullaniciAdiController.text);
  }

  void _telefonGuncelle() {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.telefonGuncelle(_telefonController.text);
  }

  void _epostaGuncelle() {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.epostaGuncelle(_epostaController.text);
  }

  void _hakkindaGuncelle() {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.hakkindaGuncelle(_hakkindaController.text);
  }

  void _bildirimAyarlari(bool deger) {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.bildirimleriDegistir(deger);
  }

  void _cevirimiciDurumAyarlari(bool deger) {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.cevirimiciDurumunuDegistir(deger);
  }

  void _sonGorulemeBilgisiAyarlari(bool deger) {
    final profilProvider = Provider.of<ProfilProvider>(context, listen: false);
    profilProvider.sonGorulemeBilgisiniDegistir(deger);
  }

  @override
  void dispose() {
    _kullaniciAdiController.dispose();
    _telefonController.dispose();
    _epostaController.dispose();
    _hakkindaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfilView(
      kullaniciAdiController: _kullaniciAdiController,
      telefonController: _telefonController,
      epostaController: _epostaController,
      hakkindaController: _hakkindaController,
      onKullaniciAdiGuncelle: _kullaniciAdiniGuncelle,
      onTelefonGuncelle: _telefonGuncelle,
      onEpostaGuncelle: _epostaGuncelle,
      onHakkindaGuncelle: _hakkindaGuncelle,
      onBildirimAyarlari: _bildirimAyarlari,
      onCevirimiciDurumAyarlari: _cevirimiciDurumAyarlari,
      onSonGorulemeBilgisiAyarlari: _sonGorulemeBilgisiAyarlari,
    );
  }
}
