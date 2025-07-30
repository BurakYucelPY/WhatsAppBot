import 'package:go_router/go_router.dart';
import '../screens/anasayfa/anasayfa.dart';
import '../screens/planlayici/planlayici.dart';
import '../screens/gecmis/gecmis.dart';
import '../screens/ayarlar/ayarlar.dart';
import 'identify_routes.dart';

final List<StatefulShellBranch> branches = [
  StatefulShellBranch(routes: [
    GoRoute(
      path: Rotalar.anasayfaPath,
      name: Rotalar.anasayfaName,
      builder: (context, state) => const AnasayfaScreen(),
    ),
  ]),
  StatefulShellBranch(routes: [
    GoRoute(
      path: Rotalar.planlayiciPath,
      name: Rotalar.planlayiciName,
      builder: (context, state) => const PlanlayiciScreen(),
    ),
  ]),
  StatefulShellBranch(routes: [
    GoRoute(
      path: Rotalar.gecmisPath,
      name: Rotalar.gecmisName,
      builder: (context, state) => const GecmisScreen(),
    ),
  ]),
  StatefulShellBranch(routes: [
    GoRoute(
      path: Rotalar.ayarlarPath,
      name: Rotalar.ayarlarName,
      builder: (context, state) => const AyarlarScreen(),
    ),
  ]),
];
