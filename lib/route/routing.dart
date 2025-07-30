import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'identify_routes.dart';
import 'branches.dart';

final router = GoRouter(
  initialLocation: Rotalar.anasayfaPath,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1a2e1a),
                  Color(0xFF213e16),
                  Color(0xFF34600f),
                ],
              ),
              boxShadow: [
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
              onTap: navigationShell.goBranch,
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
                    icon: Icon(Icons.home_rounded), label: 'Anasayfa'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.schedule_rounded), label: 'Planlayıcı'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded), label: 'Geçmiş'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_rounded), label: 'Ayarlar'),
              ],
            ),
          ),
        );
      },
      branches: branches,
    ),
  ],
);
