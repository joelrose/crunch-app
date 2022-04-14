import 'package:flutter/material.dart';
import 'package:pickup/shared/phone_number_verification.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group(
    'Phone Number',
    () {
      test(
        'is valid',
        () async {
          const phoneNumber = '+491743645092';

          expect(await phoneNumber.isValidPhoneNumber(), true);
        },
      );

      test(
        'is invalid',
        () async {
          const phoneNumber = '+49040910273';

          expect(await phoneNumber.isValidPhoneNumber(), false);
        },
      );
    },
  );
}
