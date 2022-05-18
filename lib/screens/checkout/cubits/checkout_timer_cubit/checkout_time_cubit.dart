import 'package:fleasy/fleasy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/helper.dart';

part 'checkout_time_state.dart';

part 'checkout_time_cubit.freezed.dart';

typedef ListIndex = int Function(int);

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  factory CheckoutTimeCubit({
    required DateTime currentTime,
    required List<DeliverectAvailabilityModel> openingHours,
  }) {
    openingHours.removeWhere(
      (element) => element.dayOfWeek!.index != currentTime.weekday,
    );
    final availableOpeningTimes = getOpeningHours(
        currentDateTime: currentTime, availabilityModels: openingHours);
    availableOpeningTimes.sort((a, b) => a.hour.compareTo(b.hour));

    return CheckoutTimeCubit._internal(
      pickupTime: currentTime.add(const Duration(minutes: 20)),
      currentSelectedHour: availableOpeningTimes[0],
      currentSelectedMinuteIndex: 0,
      availableOpeningTimes: availableOpeningTimes,
    );
  }

  CheckoutTimeCubit._internal({
    required DateTime pickupTime,
    required List<OpeningHour> availableOpeningTimes,
    required OpeningHour currentSelectedHour,
    required int currentSelectedMinuteIndex,
  }) : super(
          CheckoutTimeState.static(
            pickupTime,
            currentSelectedHour,
            currentSelectedMinuteIndex,
            availableOpeningTimes,
          ),
        );

  void updateCurrentSelectedMinute(int minuteIndex) {
    emit(
      state.copyWith(
        currentSelectedMinuteIndex: minuteIndex,
        pickupTime: state.pickupTime
            .copyWith(minute: state.currentSelectedHour.minutes[minuteIndex]),
      ),
    );
  }

  void updateCurrentSelectedHour(
    int hourIndex,
  ) {
    final newHour = state.availableOpeningTimes[hourIndex];
    final oldMinuteValue =
        state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex];
    final newMinuteIndex = newHour.minutes.indexOf(oldMinuteValue);

    if (newMinuteIndex == -1) {
      emit(
        state.copyWith(
          currentSelectedHour: newHour,
          currentSelectedMinuteIndex: 0,
          pickupTime: state.pickupTime
              .copyWith(hour: newHour.hour, minute: newHour.minutes[0]),
        ),
      );
      //minuteController.jumpToItem(0);
    } else {
      emit(
        state.copyWith(
          pickupTime: state.pickupTime.copyWith(
            hour: newHour.hour,
            minute: oldMinuteValue,
          ),
          currentSelectedHour: newHour,
          currentSelectedMinuteIndex: newMinuteIndex,
        ),
      );
      //minuteController.jumpToItem(newMinuteIndex);
    }
  }
}
