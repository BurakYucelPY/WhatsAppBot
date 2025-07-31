import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'screens/ayarlar/tema/tema.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
