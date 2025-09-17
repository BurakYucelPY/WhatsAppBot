import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/profil_provider.dart';

class ProfilView extends StatelessWidget {
  final TextEditingController kullaniciAdiController;
  final TextEditingController telefonController;
  final TextEditingController epostaController;
  final TextEditingController hakkindaController;
  final VoidCallback onKullaniciAdiGuncelle;
  final VoidCallback onTelefonGuncelle;
  final VoidCallback onEpostaGuncelle;
  final VoidCallback onHakkindaGuncelle;
  final Function(bool) onBildirimAyarlari;
  final Function(bool) onCevirimiciDurumAyarlari;
  final Function(bool) onSonGorulemeBilgisiAyarlari;

  const ProfilView({
    super.key,
    required this.kullaniciAdiController,
    required this.telefonController,
    required this.epostaController,
    required this.hakkindaController,
    required this.onKullaniciAdiGuncelle,
    required this.onTelefonGuncelle,
    required this.onEpostaGuncelle,
    required this.onHakkindaGuncelle,
    required this.onBildirimAyarlari,
    required this.onCevirimiciDurumAyarlari,
    required this.onSonGorulemeBilgisiAyarlari,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Consumer<ProfilProvider>(
        builder: (context, profilProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profil Avatarı
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.7),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Kullanıcı Bilgileri
                _buildInfoCard(
                  'Kullanıcı Adı',
                  kullaniciAdiController,
                  onKullaniciAdiGuncelle,
                  Icons.person_outline,
                ),
                const SizedBox(height: 16),
                
                _buildInfoCard(
                  'Telefon',
                  telefonController,
                  onTelefonGuncelle,
                  Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                
                _buildInfoCard(
                  'E-posta',
                  epostaController,
                  onEpostaGuncelle,
                  Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                
                _buildInfoCard(
                  'Hakkında',
                  hakkindaController,
                  onHakkindaGuncelle,
                  Icons.info_outline,
                  maxLines: 3,
                ),
                const SizedBox(height: 30),
                
                // Gizlilik Ayarları
                _buildSectionTitle('Gizlilik Ayarları'),
                const SizedBox(height: 16),
                
                _buildSwitchTile(
                  'Bildirimler',
                  'Mesaj bildirimlerini al',
                  profilProvider.bildirimlerAktif,
                  onBildirimAyarlari,
                  Icons.notifications_outlined,
                ),
                
                _buildSwitchTile(
                  'Çevrimiçi Durumu',
                  'Çevrimiçi durumunu göster',
                  profilProvider.cevirimiciDurumGoster,
                  onCevirimiciDurumAyarlari,
                  Icons.circle_outlined,
                ),
                
                _buildSwitchTile(
                  'Son Görülme',
                  'Son görülme bilgisini göster',
                  profilProvider.sonGorulemeBilgisiGoster,
                  onSonGorulemeBilgisiAyarlari,
                  Icons.schedule_outlined,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    TextEditingController controller,
    VoidCallback onUpdate,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  maxLines: maxLines,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Buraya yazın...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                  onEditingComplete: onUpdate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: Colors.white.withOpacity(0.8),
                size: 24,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              trailing: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: Colors.white.withOpacity(0.3),
                inactiveThumbColor: Colors.white.withOpacity(0.5),
                inactiveTrackColor: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}