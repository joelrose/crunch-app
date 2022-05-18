import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

extension DateFormatter on DateTime {
  String formatToLocalTime(String languageCode) {
    initializeDateFormatting(languageCode);
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

extension GetStartOpeningHour on DateTime {
  OpeningHour get fromStartingHour {
    return OpeningHour(
      hour,
      List.generate(
        60 - minute,
        (index) => index + minute,
      ),
    );
  }
}

extension GetEndingOpeningHours on String {
  OpeningHour get fromEndingHour {
    return OpeningHour(
      getHour,
      List.generate(getMinutes + 1, (index) => index),
    );
  }
}
