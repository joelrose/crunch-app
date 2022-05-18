import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';

List<OpeningHour> getOpeningHours(
    {required DateTime currentDateTime,
    required List<DeliverectAvailabilityModel> availabilityModels}) {
  final List<OpeningHour> openingHours = [];
  final pickUpTime = currentDateTime.add(const Duration(minutes: 20));
  for (final e in availabilityModels) {
    openingHours.add(
      pickUpTime.fromStartingHour,
    );
    if (e.endTime!.getMinutes != 0) {
      openingHours.add(e.endTime!.fromEndingHour);
    }

    for (int i = pickUpTime.hour + 1; i < e.endTime!.getHour; i++) {
      openingHours.add(i.toOpeningHour);
    }
  }
  return openingHours;
}
