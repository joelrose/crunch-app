import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

void main() {
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
    DeliverectAvailabilityModel(
      dayOfWeek: DeliverectDay.thursday,
      startTime: '13:00',
      endTime: '14:00',
    ),
  ];
  final dummyAvailableOpeningHours = [
    OpeningHour(10, List.generate(45, (index) => index + 15)),
    OpeningHour(11, List.generate(60, (index) => index)),
    OpeningHour(13, List.generate(60, (index) => index))
  ];

  group('InitalState of CheckoutTimeCubit', () {
    final dummyState = CheckoutTimeCubit(
      currentTime: dummyCurrentTime,
      openingHours: dummyOpeningHours,
    ).state;
    test('pickUpTime', () {
      expect(dummyState.pickupTime, dummyPickupTime);
    });
    test('selected hour', () {
      expect(dummyState.currentSelectedHour, dummyAvailableOpeningHours[0]);
    });
    test('selected minute index', () {
      expect(dummyState.currentSelectedMinuteIndex, 0);
    });
  });
}
