import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/kisi_provider.dart';
import '../../tema/tema.dart';

class KisiDuzenleView extends StatelessWidget {
  const KisiDuzenleView({super.key});

  @override
  Widget build(BuildContext context) {
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Kişi Düzenle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Consumer<KisiProvider>(
                builder: (context, kisiProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: kisiProvider.kisiler.length,
                      itemBuilder: (context, index) {
                        final kisi = kisiProvider.kisiler[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    title: Text(
                                      '${kisi.isim} ${kisi.soyisim}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      kisi.eposta,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      child: Text(
                                        '${kisi.isim[0]}${kisi.soyisim[0]}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
