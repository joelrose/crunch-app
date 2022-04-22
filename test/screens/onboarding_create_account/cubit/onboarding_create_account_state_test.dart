import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';
import 'package:test/test.dart';

void main() {
  group('OnboardingCreateAccountState', () {
    test('supports value comparison', () {
      expect(
        OnboardingCreateAccountState(
          data: const CreateAccountData(
            isSocialLogin: true,
            phoneNumber: '12456789',
          ),
        ),
        OnboardingCreateAccountState(
          data: const CreateAccountData(
            isSocialLogin: true,
            phoneNumber: '12456789',
          ),
        ),
      );
    });
  });
}
