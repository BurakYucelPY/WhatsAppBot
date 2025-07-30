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
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navigationShell.currentIndex,
            onTap: navigationShell.goBranch,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Anasayfa'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.schedule), label: 'Planlayıcı'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'Geçmiş'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Ayarlar'),
            ],
          ),
        );
      },
      branches: branches,
    ),
  ],
);
