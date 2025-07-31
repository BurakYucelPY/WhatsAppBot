import 'package:flutter/material.dart';
import 'package:whatsapp_bot/screens/ayarlar/tema/tema_view.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  @override
  Widget build(BuildContext context) {
    return const TemaView();
  }
}
