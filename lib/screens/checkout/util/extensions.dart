import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formatToLocalTime(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final time = DateFormat('HH:mm', languageCode).format(this);
    return time;
  }
}

extension GetTimeFromString on String {
  int get getHour {
    return int.parse(substring(0, 2));
  }

  int get getMinutes {
    return int.parse(substring(3, 5));
  }
}
