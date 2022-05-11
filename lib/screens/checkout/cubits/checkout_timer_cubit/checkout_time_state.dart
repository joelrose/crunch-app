import '/Users/florian/AndroidStudioProjects/crunch-app/lib/screens/checkout/util/extensions.dart';

part of 'checkout_time_cubit.dart';


class CheckoutTimeState extends Equatable {
  factory CheckoutTimeState({
    required DateTime pickupTime,
    required List<DeliverectAvailabilityModel> openingHours,
  }) {
    final List<OpeningHour> availableOpeningTimes = [];
    for (final e in openingHours) {
      if (e.dayOfWeek!.index == 4) {
        if (e.startTime != null) {
          final startingHour = int.parse(e.startTime!.substring(0, 2));
          final startingMinute = e.startTime?.getHour;
          availableOpeningTimes.add(
            OpeningHour(
              startingHour,
              List.generate(
                60 - startingMinute,
                (index) => index + startingMinute,
              ),
            ),
          );
        } else {
          throw Exception(
            'No StartTime was found for openingHours with ID ${e.id}',
          );
        }
        if (e.endTime != null) {
          final endingHour = int.parse(e.endTime!.substring(0, 2));
          final endingMinute = int.parse(e.endTime!.substring(3, 5));
          availableOpeningTimes.add(
            OpeningHour(
              endingHour,
              List.generate(
                endingMinute != 0 ? 60 - (60 - endingMinute) : 1,
                (index) => endingMinute - index,
              ),
            ),
          );
        } else {
          throw Exception(
            'No EndTime was found for openingHours with ID ${e.id}',
          );
        }
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
    }
    availableOpeningTimes.sort((a, b) => a.hour.compareTo(b.hour));

    return CheckoutTimeState._internal(
      pickupTime: pickupTime,
      currentSelectedHour: availableOpeningTimes[0],
      currentSelectedMinuteIndex: 0,
      availableOpeningTimes: availableOpeningTimes,
    );
  }

  const CheckoutTimeState._internal(
      {required this.pickupTime,
      required this.currentSelectedHour,
      required this.currentSelectedMinuteIndex,
      required this.availableOpeningTimes});

  CheckoutTimeState copyWith(
          {DateTime? pickupTime,
          int? currentSelectedMinuteIndex,
          OpeningHour? currentSelectedHour,
          List<OpeningHour>? availableOpeningTimes}) =>
      CheckoutTimeState._internal(
        pickupTime: pickupTime ?? this.pickupTime,
        currentSelectedMinuteIndex:
            currentSelectedMinuteIndex ?? this.currentSelectedMinuteIndex,
        availableOpeningTimes:
            availableOpeningTimes ?? this.availableOpeningTimes,
        currentSelectedHour: currentSelectedHour ?? this.currentSelectedHour,
      );

  final DateTime pickupTime;
  final List<OpeningHour> availableOpeningTimes;
  final OpeningHour currentSelectedHour;
  final int currentSelectedMinuteIndex;

  @override
  List<Object> get props =>
      [pickupTime, currentSelectedHour, currentSelectedMinuteIndex];
}
