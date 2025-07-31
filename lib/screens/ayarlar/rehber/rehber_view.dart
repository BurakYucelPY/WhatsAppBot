import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_bot/route/identify_routes.dart';

class RehberView extends StatelessWidget {
  const RehberView({super.key});

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
              Icons.contacts,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Rehber',
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
              leading: const Icon(Icons.security, color: Colors.white),
              title: const Text('Kişi ekle',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Rehbere yeni bir kişi ekleyin',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 12.6),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {
                context.goNamed(Rotalar.kisiEkleName);
              },
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            ListTile(
              leading: const Icon(Icons.palette, color: Colors.white),
              title: const Text('Kişileri düzenle',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Rehberdeki kişilerin bilgilerini düzenleyin',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 12.6),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {
                context.goNamed(Rotalar.kisiDuzenleName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
