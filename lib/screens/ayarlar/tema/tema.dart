import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/ayarlar/tema/tema_view.dart';
import '../../identify_images.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentTheme = Resimler.galaksi;

  String get currentTheme => _currentTheme;

  void changeTheme(String newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  void _changeTheme(String themePath) {
    Provider.of<ThemeProvider>(context, listen: false).changeTheme(themePath);
  }

  @override
  Widget build(BuildContext context) {
    return TemaView(
      onThemeChanged: _changeTheme,
    );
  }
}
