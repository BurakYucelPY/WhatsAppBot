import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'anasayfa.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: provider.focusedDay,
                calendarFormat: provider.calendarFormat,
                onFormatChanged: provider.changeFormat,
                selectedDayPredicate: (day) =>
                    isSameDay(provider.selectedDay, day),
                onDaySelected: provider.selectDay,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Haftalık',
                  CalendarFormat.twoWeeks: 'Aylık',
                  CalendarFormat.week: 'İki Haftalık',
                },
                calendarStyle: const CalendarStyle(
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
          );
        },
      ),
    );
  }
}
