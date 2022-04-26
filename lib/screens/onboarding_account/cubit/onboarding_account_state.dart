part of 'onboarding_account_cubit.dart';

class OnboardingAccountState extends Equatable {
  const OnboardingAccountState({required this.isSignUp});

  final bool isSignUp;

  @override
  List<Object> get props => [isSignUp];
}
