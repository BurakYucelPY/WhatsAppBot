import 'dart:ui';
import 'package:flutter/material.dart';

class SifirlaView extends StatelessWidget {
  const SifirlaView({super.key});

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
              Icons.settings_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Ayarlar',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.delete_sweep, color: Colors.white),
              title: const Text('Geçmişi Sıfırla',
                  style: TextStyle(color: Colors.white)),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {},
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            ListTile(
              leading: const Icon(Icons.contact_page, color: Colors.white),
              title: const Text('Rehberi Sıfırla',
                  style: TextStyle(color: Colors.white)),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {},
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            ListTile(
              leading: const Icon(Icons.restore, color: Colors.white),
              title: const Text('Uygulamayı Sıfırla',
                  style: TextStyle(color: Colors.white)),
              trailing:
                  const Icon(Icons.radio_button_unchecked, color: Colors.white),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
