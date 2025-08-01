import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'planlayici.dart';

class PlanlayiciView extends StatelessWidget {
  const PlanlayiciView({super.key});

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
              Icons.schedule_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Planlayıcı',
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
      body: Consumer<PlanlayiciProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Column(
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
                            'Planlanan Mesajlar',
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
                      child: ListView.builder(
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
                              'mesaj':
                                  'Ödevini bitirdin mi? Yarın son teslim tarihi.'
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

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Alıcı: ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: mesajlar[index]['alici'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            mesajlar[index]['tarih']!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            mesajlar[index]['saat']!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Divider(),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Gönderilecek mesaj: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: mesajlar[index]['mesaj'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: provider.modalAc,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Ekle',
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
                  ),
                ],
              ),
              if (provider.modalGorunur)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mesaj Planla',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Tarih: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final DateTime? tarih =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                    );
                                    if (tarih != null) {
                                      provider.tarihAyarla(tarih);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      provider.secilenTarih != null
                                          ? "${provider.secilenTarih!.day}/${provider.secilenTarih!.month}/${provider.secilenTarih!.year}"
                                          : 'Tarih Seç',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                'Saat: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? saat =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (saat != null) {
                                      provider.saatAyarla(saat);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      provider.secilenSaat != null
                                          ? "${provider.secilenSaat!.hour.toString().padLeft(2, '0')}:${provider.secilenSaat!.minute.toString().padLeft(2, '0')}"
                                          : 'Saat Seç',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Alıcı:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            onChanged: provider.aliciAyarla,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Alıcı adını girin',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Mesaj:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            onChanged: provider.mesajAyarla,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Mesajınızı girin',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: provider.modalKapat,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red.withOpacity(0.8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'İptal',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: provider.mesajPlanla,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blueGrey.withOpacity(0.8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'Mesajı Planla',
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
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
