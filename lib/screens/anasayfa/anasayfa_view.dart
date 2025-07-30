import 'package:flutter/material.dart';

class AnasayfaView extends StatelessWidget {
  const AnasayfaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Ana Sayfa',
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
      body: const Center(
        child: Text('Anasayfa'),
      ),
    );
  }
}
