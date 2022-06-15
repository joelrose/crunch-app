import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/onboarding_account/onboarding_account.dart';

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
