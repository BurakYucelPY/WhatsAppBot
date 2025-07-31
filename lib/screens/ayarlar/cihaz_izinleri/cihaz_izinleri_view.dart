import 'dart:ui';

import 'package:flutter/material.dart';

class CihazIzinleriView extends StatelessWidget {
  const CihazIzinleriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Icons.security,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Cihaz İzinleri',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: const Center(
        child: Text('Cihaz İzinleri Sayfası'),
      ),
    );
  }
}
