import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/checkout/checkout.dart';

void main() {
  group('check if extracting hours and minutes work', () {
    test('if extracting time from string works', () {
      //ARRANGE
      var timeString = "12:30";
      //ACT
      var minutes = timeString.getMinutes;
      var hour = timeString.getHour;
      //ASSERT
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
