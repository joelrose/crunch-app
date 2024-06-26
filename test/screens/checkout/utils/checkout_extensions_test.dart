import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

void main() {
  const mockTimeString = '12:05';

  group('check if creating the opening Houres works', () {
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
        equals(5),
      );
    });

    test('check if extension DateTime to local time works', () {
      final mockDate = DateTime(2022, 10, 12, 12, 30);
      final formatted = mockDate.formatToLocalTime('de');
      expect(formatted, '12:30');
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
