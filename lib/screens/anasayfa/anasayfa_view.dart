import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'anasayfa.dart';
import '../../providers/mesaj_listesi_provider.dart';
import '../../providers/kisi_provider.dart';

class AnasayfaView extends StatelessWidget {
  const AnasayfaView({super.key});

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
      backgroundColor: Colors.transparent,
      body: Consumer<CalendarProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: provider.focusedDay,
                        calendarFormat: provider.calendarFormat,
                        onFormatChanged: provider.formatDegistir,
                        selectedDayPredicate: (day) =>
                            isSameDay(provider.selectedDay, day),
                        onDaySelected: provider.gunSec,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Haftalık',
                          CalendarFormat.twoWeeks: 'Aylık',
                          CalendarFormat.week: 'İki Haftalık',
                        },
                        rowHeight: 70,
                        daysOfWeekHeight: 40,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: true,
                          headerPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
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
                            'Yaklaşan Mesaj',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<MesajListesiProvider>(
                        builder: (context, mesajProvider, child) {
                          final enYakinMesaj = mesajProvider.enYakinMesaj;

                          if (enYakinMesaj == null) {
                            return const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Henüz planlanmış mesaj yok',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '--/--/----',
                                          style: TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '--:--',
                                          style: TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Divider(),
                                Text(
                                  'Mesaj planlamak için takvimden bir tarih seçin',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
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
                                          text: enYakinMesaj.alici,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${enYakinMesaj.tarih.day.toString().padLeft(2, '0')}/${enYakinMesaj.tarih.month.toString().padLeft(2, '0')}/${enYakinMesaj.tarih.year}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        enYakinMesaj.saat,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
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
                                      text: enYakinMesaj.mesaj,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mesaj Planla',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                provider.modalSecilenTarih != null
                                    ? "${provider.modalSecilenTarih!.day}/${provider.modalSecilenTarih!.month}/${provider.modalSecilenTarih!.year}"
                                    : "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          Consumer<KisiProvider>(
                            builder: (context, kisiProvider, child) {
                              return DropdownButtonFormField<String>(
                                value: provider.alici.isEmpty
                                    ? null
                                    : provider.alici,
                                onChanged: (value) =>
                                    provider.aliciAyarla(value ?? ''),
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: Colors.grey.withOpacity(0.8),
                                decoration: InputDecoration(
                                  hintText: 'Kişi seçin',
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
                                items: kisiProvider.kisiler.map((kisi) {
                                  return DropdownMenuItem<String>(
                                    value: kisi.tamIsim,
                                    child: Text(
                                      kisi.tamIsim,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
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
                                  onPressed: () =>
                                      provider.mesajPlanla(context),
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
