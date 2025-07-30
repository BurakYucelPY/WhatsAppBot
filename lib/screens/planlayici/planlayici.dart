import 'package:flutter/material.dart';
import 'package:whatsapp_bot/screens/planlayici/planlayici_view.dart';

class PlanlayiciScreen extends StatefulWidget {
  const PlanlayiciScreen({super.key});

  @override
  State<PlanlayiciScreen> createState() => _PlanlayiciScreenState();
}

class _PlanlayiciScreenState extends State<PlanlayiciScreen> {
  @override
  Widget build(BuildContext context) {
    return const PlanlayiciView();
  }
}
