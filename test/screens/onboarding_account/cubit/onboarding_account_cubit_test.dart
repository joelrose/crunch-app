import 'package:pickup/screens/onboarding_account/onboarding_account.dart';
import 'package:test/test.dart';

void main() {
  group('RocketDetailsCubit', () {
    test('initial state is correct', () {
      expect(
        OnboardingAccountCubit(isSignUp: true).state,
        equals(const OnboardingAccountState(isSignUp: true)),
      );
    });
  });
}
