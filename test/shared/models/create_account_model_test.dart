import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/shared/models/create_account_model.dart';

void main() {
  group('Create Account Data Model', () {
    test('without phone number', () {
      final data = CreateAccountData(isSocialLogin: true);

      expect(data.isSocialLogin, true);
      expect(data.phoneNumber, null);
    });

    test('with phone number', () {
      final data = CreateAccountData(
        isSocialLogin: true,
        phoneNumber: '03012345',
      );

      expect(data.isSocialLogin, true);
      expect(data.phoneNumber, '03012345');
    });
  });
}
