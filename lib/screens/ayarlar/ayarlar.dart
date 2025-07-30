import 'package:flutter/material.dart';
import 'ayarlar_view.dart';

class AyarlarScreen extends StatefulWidget {
  const AyarlarScreen({super.key});

  @override
  State<AyarlarScreen> createState() => _AyarlarScreenState();
}

class _AyarlarScreenState extends State<AyarlarScreen> {
  @override
  Widget build(BuildContext context) {
    return const AyarlarView();
  }
}
