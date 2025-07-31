import 'package:go_router/go_router.dart';
import '../screens/anasayfa/anasayfa.dart';
import '../screens/planlayici/planlayici.dart';
import '../screens/gecmis/gecmis.dart';
import '../screens/ayarlar/ayarlar.dart';
import '../screens/ayarlar/cihaz_izinleri/cihaz_izinleri.dart';
import '../screens/ayarlar/tema/tema.dart';
import '../screens/ayarlar/rehber/rehber.dart';
import 'identify_routes.dart';

final List<StatefulShellBranch> branches = [
  StatefulShellBranch(initialLocation: Rotalar.anasayfaPath, routes: [
    GoRoute(
      path: Rotalar.anasayfaPath,
      name: Rotalar.anasayfaName,
      builder: (context, state) => const AnasayfaScreen(),
    ),
  ]),
  StatefulShellBranch(initialLocation: Rotalar.planlayiciPath, routes: [
    GoRoute(
      path: Rotalar.planlayiciPath,
      name: Rotalar.planlayiciName,
      builder: (context, state) => const PlanlayiciScreen(),
    ),
  ]),
  StatefulShellBranch(initialLocation: Rotalar.gecmisPath, routes: [
    GoRoute(
      path: Rotalar.gecmisPath,
      name: Rotalar.gecmisName,
      builder: (context, state) => const GecmisScreen(),
    ),
  ]),
  StatefulShellBranch(initialLocation: Rotalar.ayarlarPath, routes: [
    GoRoute(
      path: Rotalar.ayarlarPath,
      name: Rotalar.ayarlarName,
      builder: (context, state) => const AyarlarScreen(),
      routes: [
        GoRoute(
          path: Rotalar.cihazIzinleriPath,
          name: Rotalar.cihazIzinleriName,
          builder: (context, state) => const CihazIzinleriScreen(),
        ),
        GoRoute(
          path: Rotalar.temaPath,
          name: Rotalar.temaName,
          builder: (context, state) => const TemaScreen(),
        ),
        GoRoute(
          path: Rotalar.rehberPath,
          name: Rotalar.rehberName,
          builder: (context, state) => const RehberScreen(),
        ),
      ],
    ),
  ]),
];
