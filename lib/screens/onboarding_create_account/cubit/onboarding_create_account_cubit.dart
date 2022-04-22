import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pickup/shared/models/create_account_model.dart';

part 'onboarding_create_account_state.dart';

class OnboardingCreateAccountCubit extends Cubit<OnboardingCreateAccountState> {
  OnboardingCreateAccountCubit() : super(const OnboardingCreateAccountState());
}
