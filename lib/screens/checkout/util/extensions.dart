import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:intl/intl.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

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

extension GetOpeningHourFromInt on int {
  OpeningHour get toOpeningHour {
    return OpeningHour(this, List.generate(60, (index) => index));
  }
}

extension GetOpeningHours on String {
  OpeningHour get fromEndingHour {
    return OpeningHour(
      getHour,
      List.generate(getMinutes, (index) => getMinutes - index),
    );
  }

  OpeningHour get fromStartingHour {
    return OpeningHour(
      getHour,
      List.generate(
        60 - getMinutes,
        (index) => index + getMinutes,
      ),
    );
  }
}

extension GetListOfOpeningHoures on List<DeliverectAvailabilityModel> {
  List<OpeningHour> get getOpeningHours {
    final List<OpeningHour> openingHours = [];
    for (final e in this) {
      openingHours.add(e.startTime!.fromStartingHour);
      if (e.endTime!.getMinutes != 0) {
        openingHours.add(e.endTime!.fromEndingHour);
      }

      for (int i = e.startTime!.getHour + 1; i < e.endTime!.getHour; i++) {
        openingHours.add(i.toOpeningHour);
      }
    }

    return openingHours;
  }
}
