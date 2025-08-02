import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_bot/screens/giris/login/login.dart';
import 'package:whatsapp_bot/screens/giris/register/register.dart';
import 'dart:ui';
import 'identify_routes.dart';
import 'branches.dart';
import '../screens/ayarlar/tema/tema.dart';

final router = GoRouter(
  initialLocation: Rotalar.loginPath,
  routes: [
    GoRoute(
      path: Rotalar.loginPath,
      name: Rotalar.loginName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Rotalar.registerPath,
      name: Rotalar.registerName,
      builder: (context, state) => const RegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(themeProvider.currentTheme),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: navigationShell,
                  bottomNavigationBar: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 15,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: navigationShell.currentIndex,
                          onTap: (index) {
                            if (navigationShell.currentIndex == index) {
                              navigationShell.goBranch(index,
                                  initialLocation: true);
                            } else {
                              navigationShell.goBranch(index);
                            }
                          },
                          backgroundColor: Colors.transparent,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.grey[400],
                          selectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          items: const [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home_rounded),
                                label: 'Anasayfa'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.schedule_rounded),
                                label: 'Planlayıcı'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.history_rounded),
                                label: 'Geçmiş'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.settings_rounded),
                                label: 'Ayarlar'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      branches: branches,
    ),
  ],
);
