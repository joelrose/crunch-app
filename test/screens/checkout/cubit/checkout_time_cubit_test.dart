import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

void main() {
  var mockGetMenuResponseDto = GetMenuResponseDto(
      menu: DeliverectMenuDto(availabilities: [
    DeliverectAvailabilityModel(
        endTime: '12:00', startTime: "09:00", dayOfWeek: DeliverectDay.thursday)
  ]));

  var mockResultState = CheckoutTimeState.internal(
      pickupTime: DateTime(1,1,1,1).add(Duration(minutes: 20)),
      currentSelectedMinuteIndex: 0,
      availableOpeningTimes: [
        OpeningHour(9, List.generate(60, (index) => index)),
        OpeningHour(10, List.generate(60, (index) => index)),
        OpeningHour(11, List.generate(60, (index) => index)),
        OpeningHour(12, [0])
      ],
      currentSelectedHour: OpeningHour(9, List.generate(60, (index) => index)));

  group('check if factory constructor works', () {
    test('initial state is correct', () {
      expect(
        CheckoutTimeCubit(
                currentTime: DateTime(1,1,1,1),
                openingHours: mockGetMenuResponseDto.menu?.availabilities)
            .state,
        equals(mockResultState),
      );
    });
  });
}
