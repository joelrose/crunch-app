import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/cubits/checkout_timer_cubit/checkout_time_cubit.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';

CheckoutTimeCubit buildCubit(
    {required DateTime currentTime,
    required List<DeliverectAvailabilityModel> openingHours}) {
  return CheckoutTimeCubit(
      currentTime: currentTime, openingHours: openingHours);
}

void main() {
  group('InitialState of CheckoutTimeCubit for different cases', () {
    test('no hour change, one openinghour', () {
      final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);
      final mockOpeningHours = [
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
      final mockPickupTime = DateTime(2022, 5, 12, 10, 15);
      final mockOpeningHour =
          OpeningHour(10, List.generate(45, (index) => index + 15));
      final mockAvailableOpeningHours = [
        OpeningHour(10, List.generate(45, (index) => index + 15)),
        OpeningHour(11, List.generate(60, (index) => index)),
      ];
      expect(
        buildCubit(currentTime: mockCurrentTime, openingHours: mockOpeningHours)
            .state,
        CheckoutTimeState.static(
          mockPickupTime,
          mockOpeningHour,
          0,
          mockAvailableOpeningHours,
        ),
      );
    });
    test('no hour change, multiple openinghour', () {
      final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);
      final mockOpeningHours = [
        DeliverectAvailabilityModel(
          dayOfWeek: DeliverectDay.thursday,
          startTime: '09:00',
          endTime: '12:00',
        ),
        DeliverectAvailabilityModel(
          dayOfWeek: DeliverectDay.thursday,
          startTime: '14:00',
          endTime: '16:00',
        ),
      ];
      final mockPickupTime = DateTime(2022, 5, 12, 10, 15);
      final mockOpeningHour =
          OpeningHour(10, List.generate(45, (index) => index + 15));
      final mockAvailableOpeningHours = [
        OpeningHour(10, List.generate(45, (index) => index + 15)),
        OpeningHour(11, List.generate(60, (index) => index)),
        OpeningHour(14, List.generate(60, (index) => index)),
        OpeningHour(15, List.generate(60, (index) => index)),
      ];
      expect(
        buildCubit(currentTime: mockCurrentTime, openingHours: mockOpeningHours)
            .state,
        CheckoutTimeState.static(
          mockPickupTime,
          mockOpeningHour,
          0,
          mockAvailableOpeningHours,
        ),
      );
    });
  });

  group('CheckoutTimeCubit functions', () {
    final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);
    final mockOpeningHours = [
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
    final mockAvailableOpeningHours = [
      OpeningHour(10, List.generate(45, (index) => index + 15)),
      OpeningHour(11, List.generate(60, (index) => index)),
    ];

    blocTest<CheckoutTimeCubit, CheckoutTimeState>(
      'updateCurrentSelectedHour',
      build: () => buildCubit(
        currentTime: mockCurrentTime,
        openingHours: mockOpeningHours,
      ),
      act: (cubit) => cubit.updateCurrentSelectedHour(1),
      expect: () => [
        CheckoutTimeState.static(
          DateTime(2022, 5, 12, 11, 15),
          mockAvailableOpeningHours[1],
          15,
          mockAvailableOpeningHours,
        )
      ],
    );
  });
}
