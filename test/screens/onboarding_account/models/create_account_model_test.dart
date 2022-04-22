import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';

void main() {
  group('Create Account Data Model', () {
    test('without phone number', () {
      const data = CreateAccountData(isSocialLogin: true);

      expect(data.isSocialLogin, true);
      expect(data.phoneNumber, null);
    });

    test('with phone number', () {
      const data = CreateAccountData(
        isSocialLogin: true,
        phoneNumber: '03012345',
      );

      expect(data.isSocialLogin, true);
      expect(data.phoneNumber, '03012345');
    });
  });
}
