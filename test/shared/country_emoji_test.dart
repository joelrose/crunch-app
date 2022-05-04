import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/shared/country_emoji.dart';

void main() {
  test(
    'country code to emojiu return correct result',
    () async {
      final emoji = Utils.countryCodeToEmoji('DE');

      expect(emoji, '🇩🇪');
    },
  );
}
