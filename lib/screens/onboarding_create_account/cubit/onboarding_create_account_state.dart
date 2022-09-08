part of 'onboarding_create_account_cubit.dart';

enum OnboardingStep { phoneVerification, name, placeholder }

class OnboardingCreateAccountState extends Equatable {
  OnboardingCreateAccountState({
    OnboardingStep? step,
    required this.data,
  })  : maxSteps = 2,
        step = step ??
            (data.isSocialLogin
                ? OnboardingStep.name
                : OnboardingStep.phoneVerification);

  final CreateAccountData data;
  final OnboardingStep step;
  final int maxSteps;

  OnboardingCreateAccountState copyWith({
    OnboardingStep? step,
    CreateAccountData? data,
  }) {
    return OnboardingCreateAccountState(
      step: step ?? this.step,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [step, data, maxSteps];
}
