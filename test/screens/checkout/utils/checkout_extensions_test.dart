import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

void main() {
  const mockTimeString = '12:05';

  final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);

  group('check if creating the opening Houres works', () {
    test('check if creation of Opening hour from current time works', () {
      final startOpeningHour = mockCurrentTime.fromStartingHour;
      expect(startOpeningHour, const OpeningHour(9, [55, 56, 57, 58, 59]));
    });

    test('check if creation of end Opening hour', () {
      final endingHour = mockTimeString.fromEndingHour;

      expect(endingHour, const OpeningHour(12, [0, 1, 2, 3, 4, 5]));
    });
  });

  group('check if extracting hours and minutes work', () {
    test('if extracting minutes from String', () {
      final minutes = mockTimeString.getMinutes;

      expect(
        minutes,
        equals(30),
      );
    });

    test('if extracting houres from String', () {
      final hour = mockTimeString.getHour;

      expect(
        hour,
        equals(12),
      );
    });
  });
}
