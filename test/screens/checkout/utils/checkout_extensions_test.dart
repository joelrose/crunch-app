import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/checkout/checkout.dart';

void main() {
  group('check if extracting hours and minutes work', () {
    test('if extracting time from string works', () {

      const timeString = '12:30';

      final minutes = timeString.getMinutes;
      final hour = timeString.getHour;

      expect(
        minutes,
        equals(30),
      );
      expect(
        hour,
        equals(12),
      );
    });
  });
}
