part of 'onboarding_create_account_cubit.dart';

enum OnboardingStep { phoneVerification, password, name, placeholder }

class OnboardingCreateAccountState extends Equatable {
  const OnboardingCreateAccountState({
    this.step = OnboardingStep.phoneVerification,
    required this.data,
  });

  final OnboardingStep step;
  final CreateAccountData data;

  @override
  List<Object> get props => [step, data];
}
