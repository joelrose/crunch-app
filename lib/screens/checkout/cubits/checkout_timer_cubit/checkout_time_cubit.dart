import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

part 'checkout_time_state.dart';

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  CheckoutTimeCubit({required List<DeliverectAvailabilityModel>? openingHours})
      : super(
    CheckoutTimeState(
      pickupTime: DateTime.now().add(const Duration(minutes: 20)),
      openingHours: openingHours ?? [],
    ),
  );

  void updatePickupTime() {
    var today = DateTime.now();
    var newTime = DateTime(
        today.year, today.month, today.day, state.currentSelectedHour.hour,
        state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex]);
    emit(state.copyWith(pickupTime: newTime));
  }

  void updateCurrentSelectedMinute(int minIndex) {
    emit(state.copyWith(
      currentSelectedMinuteIndex: minIndex,
    ));
  }

  void updateCurrentSelectedHour(int hourIndex) {
    emit(state.copyWith(
        currentSelectedHour: state.availableOpeningTimes[hourIndex],
        currentSelectedMinuteIndex: 0));
  }
}
