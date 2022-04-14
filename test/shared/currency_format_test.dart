import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/shared/utilities.dart';

void main() {
  group('Utilities currency format', () {
    test('positive integer', () {
      expect(Utilities.currencyFormat(1000), '10.00 €');
    });

    test('positive double', () {
      expect(Utilities.currencyFormat(1111.111111), '11.11 €');
    });

    test('null', () {
      expect(Utilities.currencyFormat(0), '0.00 €');
    });

    test('negative integer', () {
      expect(Utilities.currencyFormat(-100), '-1.00 €');
    });

    test('negative double', () {
      expect(Utilities.currencyFormat(-1.1111111), '-0.01 €');
    });
  });
}
