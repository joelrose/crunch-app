import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_time_state.dart';

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  CheckoutTimeCubit() : super(CheckoutTimeState());

  void updatePickupTime(DateTime newTime) {
    emit(CheckoutTimeState(pickupTime: newTime));
  }
}
