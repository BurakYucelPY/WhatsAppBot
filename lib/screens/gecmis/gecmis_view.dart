import 'dart:ui';
import 'package:flutter/material.dart';

class GecmisView extends StatelessWidget {
  const GecmisView({super.key});

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
              Icons.history_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Geçmiş',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.schedule,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Gönderilen Mesajlar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final mesajlar = [
                    {
                      'alici': 'Ahmet Demir',
                      'tarih': '10/09/2025',
                      'saat': '09:30',
                      'mesaj':
                          'Toplantıyı unutma! Bugün saat 10:00\'da konferans salonundayız.'
                    },
                    {
                      'alici': 'Zeynep Kaya',
                      'tarih': '12/09/2025',
                      'saat': '14:15',
                      'mesaj':
                          'Doğum günün kutlu olsun! Harika bir yıl geçirmen dileğiyle.'
                    },
                    {
                      'alici': 'Mehmet Şahin',
                      'tarih': '15/09/2025',
                      'saat': '16:45',
                      'mesaj':
                          'Proje dosyalarını incelediğin için teşekkürler. Geri bildirimlerini bekliyorum.'
                    },
                    {
                      'alici': 'Fatma Yılmaz',
                      'tarih': '18/09/2025',
                      'saat': '11:20',
                      'mesaj':
                          'Pazartesi günü doktor randevumu hatırlat lütfen.'
                    },
                    {
                      'alici': 'Ali Öz',
                      'tarih': '20/09/2025',
                      'saat': '19:00',
                      'mesaj':
                          'Akşam maçı izlemeye gelir misin? Evin yolu üstünde.'
                    },
                    {
                      'alici': 'Ayşe Çelik',
                      'tarih': '22/09/2025',
                      'saat': '08:00',
                      'mesaj':
                          'Günaydın! Bugün hava çok güzel, piknik planını unutma.'
                    },
                    {
                      'alici': 'Emre Polat',
                      'tarih': '25/09/2025',
                      'saat': '13:30',
                      'mesaj': 'Ödevini bitirdin mi? Yarın son teslim tarihi.'
                    },
                    {
                      'alici': 'Selin Ak',
                      'tarih': '28/09/2025',
                      'saat': '17:20',
                      'mesaj':
                          'Fotoğrafları gördüm, harika çekmişsin! Tebrikler.'
                    },
                    {
                      'alici': 'Okan Demir',
                      'tarih': '30/09/2025',
                      'saat': '21:45',
                      'mesaj':
                          'Film tavsiyesi istemiştik. Bu akşam o filmi izleyelim mi?'
                    },
                    {
                      'alici': 'Gül Şimşek',
                      'tarih': '03/10/2025',
                      'saat': '12:10',
                      'mesaj':
                          'Çay içmeye gel, uzun zamandır görüşmedik. Özledim seni.'
                    },
                  ];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Alıcı: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: mesajlar[index]['alici'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mesajlar[index]['tarih']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              mesajlar[index]['saat']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Divider(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gönderilen mesaj:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  mesajlar[index]['mesaj']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Düzenle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
