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

  void updatePickupTime(DateTime newTime) {
    //emit(CheckoutTimeState(pickupTime: newTime));
  }

  void updateCurrentSelectedMinute(int minIndex) {
    emit(state.copyWith(currentSelectedMinute: minIndex,));
  }

  void updateCurrentSelectedHour(int hourIndex) {
    // var hour = state.availableOpeningTimes.keys.toList()[hourIndex];
    // emit(state.copyWith(currentSelectedHour: hour, currentSelectedMinute: 0));
  }
}
