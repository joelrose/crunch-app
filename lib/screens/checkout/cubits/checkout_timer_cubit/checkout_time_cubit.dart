import 'package:equatable/equatable.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';

part 'checkout_time_state.dart';

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  CheckoutTimeCubit(
      {required List<DeliverectAvailabilityModel>? openingHours,
      required DateTime currentTime})
      : super(
          CheckoutTimeState(
            pickupTime: currentTime.add(const Duration(minutes: 20)),
            openingHours: openingHours ?? [],
          ),
        );

  void updatePickupTime() {
    var today = DateTime.now();
    var newTime = DateTime(
        today.year,
        today.month,
        today.day,
        state.currentSelectedHour.hour,
        state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex]);
    emit(state.copyWith(pickupTime: newTime));
  }

  void updateCurrentSelectedMinute(int minIndex) {
    emit(state.copyWith(
        currentSelectedMinuteIndex: minIndex,
        pickupTime: state.pickupTime
            .copyWith(minute: state.currentSelectedHour.minutes[minIndex])));
  }

  void updateCurrentSelectedHour(int hourIndex) {
    var newHour = state.availableOpeningTimes[hourIndex];
    var newMinuteIndex = newHour.minutes.indexOf(
        state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex]);

    if (newHour.minutes.contains(
        state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex])) {
      emit(
        state.copyWith(
            pickupTime: state.pickupTime.copyWith(
                hour: newHour.hour,
                minute: state.currentSelectedHour
                    .minutes[state.currentSelectedMinuteIndex]),
            currentSelectedHour: newHour,
            currentSelectedMinuteIndex: newMinuteIndex),
      );
    } else {
      emit(
        state.copyWith(
            currentSelectedHour: newHour,
            currentSelectedMinuteIndex: 0,
            pickupTime: state.pickupTime
                .copyWith(hour: newHour.hour, minute: newHour.minutes[0])),
      );
    }
  }
}
