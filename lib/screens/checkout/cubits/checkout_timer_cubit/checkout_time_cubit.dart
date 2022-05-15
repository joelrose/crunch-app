import 'package:fleasy/fleasy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';

part 'checkout_time_state.dart';

part 'checkout_time_cubit.freezed.dart';

class CheckoutTimeCubit extends Cubit<CheckoutTimeState> {
  factory CheckoutTimeCubit({
    required DateTime currentTime,
    required List<DeliverectAvailabilityModel>? openingHours,
  }) {
    final List<OpeningHour> availableOpeningTimes = [];

    openingHours!.removeWhere(
        (element) => element.dayOfWeek!.index != currentTime.weekday);

    for (final e in openingHours) {
      final startTime = e.startTime;
      final startingHour = startTime!.getHour;
      final startingMinute = startTime.getMinutes;

      availableOpeningTimes.add(
        OpeningHour(
          startingHour,
          List.generate(
            60 - startingMinute,
            (index) => index + startingMinute,
          ),
        ),
      );

      final endTime = e.endTime;
      final endingHour = endTime!.getHour;
      final endingMinute = endTime.getMinutes;
      availableOpeningTimes.add(
        OpeningHour(
          endingHour,
          List.generate(
            endingMinute != 0 ? 60 - (60 - endingMinute) : 1,
            (index) => endingMinute - index,
          ),
        ),
      );

      if (e.endTime != null && e.startTime != null) {
        final startingHour = int.parse(e.startTime!.substring(0, 2));
        final endingHour = int.parse(e.endTime!.substring(0, 2));
        final allHoursBetween = List.generate(
          endingHour - startingHour - 1,
          (index) => index + startingHour + 1,
        );
        for (final e in allHoursBetween) {
          availableOpeningTimes
              .add(OpeningHour(e, List.generate(60, (index) => index)));
        }
      }
    }
    availableOpeningTimes.sort((a, b) => a.hour.compareTo(b.hour));

    availableOpeningTimes.removeWhere((e) => e.minutes.length == 1);

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

  void updatePickupTime() {
    final today = DateTime.now();
    final newTime = DateTime(
      today.year,
      today.month,
      today.day,
      state.currentSelectedHour.hour,
      state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex],
    );
    emit(state.copyWith(pickupTime: newTime));
  }

  void updateCurrentSelectedMinute(int minIndex) {
    emit(
      state.copyWith(
        currentSelectedMinuteIndex: minIndex,
        pickupTime: state.pickupTime
            .copyWith(minute: state.currentSelectedHour.minutes[minIndex]),
      ),
    );
  }

  void updateCurrentSelectedHour(int hourIndex) {
    final newHour = state.availableOpeningTimes[hourIndex];
    final newMinuteIndex = newHour.minutes.indexOf(
      state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex],
    );

    if (newHour.minutes.contains(
      state.currentSelectedHour.minutes[state.currentSelectedMinuteIndex],
    )) {
      emit(
        state.copyWith(
          pickupTime: state.pickupTime.copyWith(
            hour: newHour.hour,
            minute: state
                .currentSelectedHour.minutes[state.currentSelectedMinuteIndex],
          ),
          currentSelectedHour: newHour,
          currentSelectedMinuteIndex: newMinuteIndex,
        ),
      );
    } else {
      emit(
        state.copyWith(
          currentSelectedHour: newHour,
          currentSelectedMinuteIndex: 0,
          pickupTime: state.pickupTime
              .copyWith(hour: newHour.hour, minute: newHour.minutes[0]),
        ),
      );
    }
  }
}
