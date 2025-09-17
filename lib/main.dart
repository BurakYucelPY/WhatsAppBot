import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'screens/ayarlar/tema/tema.dart';
import 'providers/mesaj_listesi_provider.dart';
import 'providers/kisi_provider.dart';
import 'providers/profil_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MesajListesiProvider()),
        ChangeNotifierProvider(create: (_) => KisiProvider()),
        ChangeNotifierProvider(create: (_) => ProfilProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
