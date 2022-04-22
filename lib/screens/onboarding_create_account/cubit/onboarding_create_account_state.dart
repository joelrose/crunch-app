part of 'onboarding_create_account_cubit.dart';

enum OnboardingStep { phoneVerification, password, name, placeholder }

class OnboardingCreateAccountState extends Equatable {
  OnboardingCreateAccountState({
    OnboardingStep? step,
    required this.data,
  }) {
    maxSteps = data.isSocialLogin ? 2 : 4;
    this.step = step ??
        (data.isSocialLogin
            ? OnboardingStep.name
            : OnboardingStep.phoneVerification);
  }

  final CreateAccountData data;
  late OnboardingStep step;
  late int maxSteps;

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
