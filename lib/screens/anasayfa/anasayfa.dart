import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'anasayfa_view.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void changeFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }
}

class AnasayfaScreen extends StatefulWidget {
  const AnasayfaScreen({super.key});

  @override
  State<AnasayfaScreen> createState() => _AnasayfaScreenState();
}

class _AnasayfaScreenState extends State<AnasayfaScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarProvider(),
      child: const AnasayfaView(),
    );
  }
}
