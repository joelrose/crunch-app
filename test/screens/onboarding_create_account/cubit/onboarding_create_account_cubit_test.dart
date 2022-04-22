import 'package:bloc_test/bloc_test.dart';
import 'package:pickup/screens/onboarding_create_account/cubit/onboarding_create_account_cubit.dart';
import 'package:pickup/screens/onboarding_create_account/onboarding_create_account.dart';
import 'package:test/test.dart';

void main() {
  const dataSocialLogin = CreateAccountData(isSocialLogin: true);
  const dataPhoneNumber = CreateAccountData(
    isSocialLogin: false,
    phoneNumber: '+491743645092',
  );
  group('OnboardingCreateAccountCubit', () {
    test('initial state social login is correct', () {
      expect(
        OnboardingCreateAccountCubit(data: dataSocialLogin).state,
        equals(
          OnboardingCreateAccountState(
            step: OnboardingStep.name,
            data: dataSocialLogin,
          ),
        ),
      );
    });

    test('initial state phone number login is correct', () {
      expect(
        OnboardingCreateAccountCubit(data: dataPhoneNumber).state,
        equals(
          OnboardingCreateAccountState(
            step: OnboardingStep.phoneVerification,
            data: dataPhoneNumber,
          ),
        ),
      );
    });

    blocTest<OnboardingCreateAccountCubit, OnboardingCreateAccountState>(
      'emits state when calling nextStep',
      build: () => OnboardingCreateAccountCubit(data: dataSocialLogin),
      act: (cubit) => cubit.nextStep(),
      expect: () => [
        OnboardingCreateAccountState(
          step: OnboardingStep.placeholder,
          data: dataSocialLogin,
        ),
      ],
      verify: (cubit) {
        expect(cubit.state.maxSteps, 2);
      },
    );

    blocTest<OnboardingCreateAccountCubit, OnboardingCreateAccountState>(
      'emits state when calling previousStep',
      build: () => OnboardingCreateAccountCubit(data: dataPhoneNumber),
      act: (cubit) {
        cubit.nextStep();
        cubit.previousStep();
      },
      expect: () => [
        OnboardingCreateAccountState(
          step: OnboardingStep.name,
          data: dataPhoneNumber,
        ),
        OnboardingCreateAccountState(
          data: dataPhoneNumber,
        ),
      ],
      verify: (cubit) {
        expect(cubit.state.maxSteps, 3);
      },
    );
  });
}
