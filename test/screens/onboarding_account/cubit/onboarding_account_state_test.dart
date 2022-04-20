import 'package:pickup/screens/onboarding_account/onboarding_account.dart';
import 'package:test/test.dart';

void main() {
  group('OnboardingAccountState', () {
    test('supports value comparison', () {
      expect(
        const OnboardingAccountState(isSignUp: true),
        const OnboardingAccountState(isSignUp: true),
      );
    });
  });
}
