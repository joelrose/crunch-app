import 'package:equatable/equatable.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

part 'checkout_time_state.dart';

typedef ListIndex = int Function(int);

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  factory CheckoutTimeCubit({
    required DateTime currentTime,
    required List<GetStoreOpeningHour> openingHours,
  }) {
    openingHours.removeWhere(
      (element) => element.dayOfWeek! != currentTime.weekday,
    );

    /*final availableOpeningTimes = getOpeningHours(
      currentDateTime: currentTime,
      availabilityModels: openingHours,
    );
    availableOpeningTimes.sort((a, b) => a.hour.compareTo(b.hour));*/

    return CheckoutTimeCubit._internal(
      pickupTime: currentTime, // currentTime.add(const Duration(minutes: 20)),
      currentSelectedHour:
          const OpeningHour(0, []), //  availableOpeningTimes[0],
      currentSelectedMinuteIndex: 0,
      //availableOpeningTimes: availableOpeningTimes,
    );
  }

  CheckoutTimeCubit._internal({
    required DateTime pickupTime,
    //required List<OpeningHour> availableOpeningTimes,
    required OpeningHour currentSelectedHour,
    required int currentSelectedMinuteIndex,
  }) : super(
          CheckoutTimeState(
            pickupTime,
            currentSelectedHour,
            currentSelectedMinuteIndex,
           // availableOpeningTimes,
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
/*
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
  }*/
}
