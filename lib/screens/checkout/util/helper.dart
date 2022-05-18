import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/checkout/domain/entities/opening_hour.dart';
import 'package:pickup/screens/checkout/util/extensions.dart';

List<OpeningHour> getOpeningHours(
    {required DateTime currentDateTime,
    required List<DeliverectAvailabilityModel> availabilityModels}) {
  final List<OpeningHour> openingHours = [];
  for (final e in availabilityModels) {
    openingHours.add(
      currentDateTime.add(const Duration(minutes: 20)).fromStartingHour,
    );
    if (e.endTime!.getMinutes != 0) {
      openingHours.add(e.endTime!.fromEndingHour);
    }

    for (int i = e.startTime!.getHour + 1; i < e.endTime!.getHour; i++) {
      openingHours.add(i.toOpeningHour);
    }
  }
  return openingHours;
}
