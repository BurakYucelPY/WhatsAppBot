import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'screens/ayarlar/tema/tema.dart';
import 'providers/mesaj_listesi_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MesajListesiProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
