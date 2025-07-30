import 'package:flutter/material.dart';
import 'package:whatsapp_bot/screens/gecmis/gecmis_view.dart';

class GecmisScreen extends StatefulWidget {
  const GecmisScreen({super.key});

  @override
  State<GecmisScreen> createState() => _GecmisScreenState();
}

class _GecmisScreenState extends State<GecmisScreen> {
  @override
  Widget build(BuildContext context) {
    return const GecmisView();
  }
}
