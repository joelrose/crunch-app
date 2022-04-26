import 'package:pickup/shared/country_emoji.dart';
import 'package:test/test.dart';

void main() {
  test(
    'country code to emojiu return correct result',
    () async {
      final emoji = Utils.countryCodeToEmoji('DE');

      expect(emoji, '🇩🇪');
    },
  );
}
