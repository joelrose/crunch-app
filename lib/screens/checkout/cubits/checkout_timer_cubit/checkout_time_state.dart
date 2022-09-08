part of 'checkout_time_cubit.dart';

class CheckoutTimeState extends Equatable {
  const CheckoutTimeState(
    this.pickupTime,
    this.currentSelectedHour,
    this.currentSelectedMinuteIndex,
   // this.availableOpeningTimes,
  );

  final DateTime pickupTime;
  final OpeningHour currentSelectedHour;
  final int currentSelectedMinuteIndex;
  //final List<OpeningHour> availableOpeningTimes;

  CheckoutTimeState copyWith({
    DateTime? pickupTime,
    OpeningHour? currentSelectedHour,
    int? currentSelectedMinuteIndex,
    //List<OpeningHour>? availableOpeningTimes,
  }) {
    return CheckoutTimeState(
      pickupTime ?? this.pickupTime,
      currentSelectedHour ?? this.currentSelectedHour,
      currentSelectedMinuteIndex ?? this.currentSelectedMinuteIndex,
      //availableOpeningTimes ?? this.availableOpeningTimes,
    );
  }

  @override
  List<Object?> get props => [
        pickupTime,
        currentSelectedHour,
        currentSelectedMinuteIndex,
        //availableOpeningTimes
      ];
}
