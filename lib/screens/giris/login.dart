import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'login_view.dart';
import '../../route/identify_routes.dart';

class LoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _obscurePassword = true;
  bool _rememberMe = false;

  String get email => _email;
  String get password => _password;
  bool get obscurePassword => _obscurePassword;
  bool get rememberMe => _rememberMe;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  void login(BuildContext context) {
    context.goNamed(Rotalar.anasayfaName);
  }

  void resetFields() {
    _email = '';
    _password = '';
    _obscurePassword = true;
    _rememberMe = false;
    notifyListeners();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: const LoginView(),
    );
  }
}
