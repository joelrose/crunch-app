import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

final dummyCurrentTime = DateTime(2022, 5, 12, 9, 55);
final dummyPickupTime = DateTime(2022, 5, 12, 10, 15);
final dummyOpeningHours = [
  DeliverectAvailabilityModel(
    dayOfWeek: DeliverectDay.friday,
    startTime: '01:00',
    endTime: '20:00',
  ),
  DeliverectAvailabilityModel(
    dayOfWeek: DeliverectDay.thursday,
    startTime: '09:00',
    endTime: '12:00',
  ),
];
final dummyAvailableOpeningHours = [
  OpeningHour(10, List.generate(45, (index) => index + 15)),
  OpeningHour(11, List.generate(60, (index) => index)),
  //OpeningHour(13, List.generate(60, (index) => index))
];
final dummyCubit = CheckoutTimeCubit(
  currentTime: dummyCurrentTime,
  openingHours: dummyOpeningHours,
);

void main() {
  CheckoutTimeCubit buildCubit() {
    return CheckoutTimeCubit(
        currentTime: dummyCurrentTime, openingHours: dummyOpeningHours);
  }

  test('InitalState of CheckoutTimeCubit', () {
    expect(
        buildCubit().state,
        CheckoutTimeState.static(
            dummyPickupTime,
            OpeningHour(10, List.generate(45, (index) => index + 15)),
            0,
            dummyAvailableOpeningHours,),);
  });

  blocTest<CheckoutTimeCubit, CheckoutTimeState>(
    'emits success when checkout succeeds',
    build: () => buildCubit(),
    act: (cubit) => cubit.updateCurrentSelectedHour(1),
    expect: () => CheckoutTimeState.static(DateTime(2022, 5, 12, 11, 15),
        dummyAvailableOpeningHours[1], 15, dummyAvailableOpeningHours),
  );
}
