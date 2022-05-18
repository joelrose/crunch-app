import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/helper.dart';

final mockOpeningHours = [
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

final mockCurrentTime = DateTime(2022, 5, 12, 9, 55);

void main() {
  test('check getOpeningHours', () {
    final openingHours = getOpeningHours(
        currentDateTime: mockCurrentTime, availabilityModels: mockOpeningHours);
    expect(openingHours, [
      OpeningHour(10, List.generate(45, (index) => index + 15)),
      OpeningHour(11, List.generate(60, (index) => index))
    ]);
  });
}
