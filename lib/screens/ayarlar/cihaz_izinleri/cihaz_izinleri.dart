import 'package:flutter/material.dart';
import 'package:whatsapp_bot/screens/ayarlar/cihaz_izinleri/cihaz_izinleri_view.dart';

class CihazIzinleriScreen extends StatefulWidget {
  const CihazIzinleriScreen({super.key});

  @override
  State<CihazIzinleriScreen> createState() => _CihazIzinleriScreenState();
}

class _CihazIzinleriScreenState extends State<CihazIzinleriScreen> {
  @override
  Widget build(BuildContext context) {
    return const CihazIzinleriView();
  }
}
