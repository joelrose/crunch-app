part of 'checkout_time_cubit.dart';

@freezed
class CheckoutTimeState with _$CheckoutTimeState {
  const factory CheckoutTimeState.static(
    DateTime pickupTime,
    OpeningHour currentSelectedHour,
    int currentSelectedMinuteIndex,
    List<OpeningHour> availableOpeningTimes,
  ) = _Static;
}
