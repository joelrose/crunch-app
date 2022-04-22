import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/shared/phone_number_verification.dart';

void setupMethodChannel({required bool isValid}) {
  TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('com.julienvignali/phone_number'),
    (MethodCall methodCall) async {
      if (methodCall.method == 'validate') {
        return {
          'isValid': isValid,
        };
      }
      return null;
    },
  );
}

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group(
    'Phone Number',
    () {
      setUpAll(() {
        TestWidgetsFlutterBinding.ensureInitialized();
      });
      test(
        'is valid',
        () async {
          setupMethodChannel(isValid: true);

          const phoneNumber = '+491743645092';

          expect(await phoneNumber.isValidPhoneNumber(), true);
        },
      );

      test(
        'is invalid',
        () async {
          setupMethodChannel(isValid: false);

          const phoneNumber = '+49040910273';

          expect(await phoneNumber.isValidPhoneNumber(), false);
        },
      );
    },
  );
}
