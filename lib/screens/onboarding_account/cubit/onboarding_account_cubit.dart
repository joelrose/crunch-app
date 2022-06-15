import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_account_state.dart';

class OnboardingAccountCubit extends Cubit<OnboardingAccountState> {
  OnboardingAccountCubit({required bool isSignUp})
      : super(OnboardingAccountState(isSignUp: isSignUp));
}
