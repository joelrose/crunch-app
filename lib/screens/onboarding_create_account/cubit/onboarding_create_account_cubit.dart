import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/onboarding_create_account/models/models.dart';

part 'onboarding_create_account_state.dart';

class OnboardingCreateAccountCubit extends Cubit<OnboardingCreateAccountState> {
  OnboardingCreateAccountCubit({required CreateAccountData data})
      : super(OnboardingCreateAccountState(data: data));

  void previousStep() {
    emit(state.copyWith(step: OnboardingStep.values[state.step.index - 1]));
  }

  void nextStep() {
    emit(state.copyWith(step: OnboardingStep.values[state.step.index + 1]));
  }
}
