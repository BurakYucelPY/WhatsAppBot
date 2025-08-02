import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/ayarlar/cihaz_izinleri/cihaz_izinleri.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CihazIzinleriView extends StatelessWidget {
  const CihazIzinleriView({super.key});

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
              Icons.security,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Cihaz İzinleri',
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
      body: Consumer<CihazIzinleriProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.white),
                  title: const Text('Bildirimler',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Bildirim tercihlerinizi değiştirin',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.6),
                  ),
                  trailing: Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: provider.bildirim,
                      onChanged: (value) => provider.toggleBildirim(),
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.white.withOpacity(0.3),
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(color: Colors.white.withOpacity(0.3)),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.white),
                  title: const Text('Kişilerim',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Rehber erişim iznini değiştirin',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.6),
                  ),
                  trailing: Switch(
                    value: provider.kisi,
                    onChanged: (value) => provider.toggleKisi(),
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.white.withOpacity(0.3),
                    inactiveTrackColor: Colors.grey.withOpacity(0.3),
                  ),
                  onTap: () {},
                ),
                Divider(color: Colors.white.withOpacity(0.3)),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.whatsapp,
                      color: Colors.white),
                  title: const Text('WhatsApp',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'WhatsApp erişim iznini değiştirin',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.6),
                  ),
                  trailing: Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: provider.whatsapp,
                      onChanged: (value) => provider.toggleWhatsapp(),
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.white.withOpacity(0.3),
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(color: Colors.white.withOpacity(0.3)),
                ListTile(
                  leading: const Icon(Icons.mic, color: Colors.white),
                  title: const Text('Mikrafon',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Mikrofon kullanım iznini değiştirin',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.6),
                  ),
                  trailing: Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: provider.mikrofon,
                      onChanged: (value) => provider.toggleMikrofon(),
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.white.withOpacity(0.3),
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
