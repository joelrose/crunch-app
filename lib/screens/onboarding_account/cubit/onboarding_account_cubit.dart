import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_account_state.dart';

class OnboardingAccountCubit extends Cubit<OnboardingAccountState> {
  OnboardingAccountCubit({required bool isSignUp})
      : super(OnboardingAccountState(isSignUp: isSignUp));
}
