part of 'checkout_time_cubit.dart';

class CheckoutTimeState extends Equatable {
  factory CheckoutTimeState({
    required DateTime pickupTime,
    required List<DeliverectAvailabilityModel> openingHours,
  }) {
    final List<OpeningHour> availableOpeningTimes = [];
    for (final e in openingHours) {
      if (e.dayOfWeek!.index == 2) {
        if (e.startTime != null) {
          final startingHour = int.parse(e.startTime!.substring(0, 2));
          final startingMinute = int.parse(e.startTime!.substring(3, 5));
          availableOpeningTimes.add(OpeningHour(
              startingHour,
              List.generate(
                  60 - startingMinute, (index) => index + startingMinute)));
        } else {
          throw Exception(
              'No StartTime was found for openingHours with ID ${e.id}');
        }
        if (e.endTime != null) {
          final endingHour = int.parse(e.endTime!.substring(0, 2));
          final endingMinute = int.parse(e.endTime!.substring(3, 5));
          availableOpeningTimes.add(OpeningHour(
              endingHour,
              List.generate(
                  60 - (60 - endingMinute), (index) => endingMinute - index)));
        } else {
          throw Exception(
              'No EndTime was found for openingHours with ID ${e.id}');
        }
        if (e.endTime != null && e.startTime != null) {
          final startingHour = int.parse(e.startTime!.substring(0, 2));
          final endingHour = int.parse(e.endTime!.substring(0, 2));
          final allHoursBetween = List.generate(
              endingHour - startingHour, (index) => index + startingHour + 1);
          for (final e in allHoursBetween) {
            availableOpeningTimes
                .add(OpeningHour(e, List.generate(60, (index) => index)));
          }
        }
      }
    }

    return CheckoutTimeState._internal(
        pickupTime: pickupTime,
        openingHours: openingHours,
        currentSelectedHour: 9,
        currentSelectedMinute: 0,
        availableOpeningTimes: availableOpeningTimes);
  }

  const CheckoutTimeState._internal(
      {required this.pickupTime,
      required this.openingHours,
      required this.currentSelectedHour,
      required this.currentSelectedMinute,
      required this.availableOpeningTimes});

  CheckoutTimeState copyWith(
          {DateTime? pickupTime,
          List<DeliverectAvailabilityModel>? openingHours,
          int? currentSelectedHour,
          int? currentSelectedMinute,
          List<OpeningHour>? availableOpeningTimes}) =>
      CheckoutTimeState._internal(
          pickupTime: pickupTime ?? this.pickupTime,
          currentSelectedHour: currentSelectedHour ?? this.currentSelectedHour,
          openingHours: openingHours ?? this.openingHours,
          currentSelectedMinute:
              currentSelectedMinute ?? this.currentSelectedMinute,
          availableOpeningTimes:
              availableOpeningTimes ?? this.availableOpeningTimes);

  final DateTime pickupTime;
  final List<DeliverectAvailabilityModel> openingHours;
  final List<OpeningHour> availableOpeningTimes;
  final int currentSelectedHour;
  final int currentSelectedMinute;

  @override
  List<Object> get props =>
      [pickupTime, currentSelectedHour, currentSelectedMinute];
}
