part of 'checkout_time_cubit.dart';

class CheckoutTimeState extends Equatable {
  CheckoutTimeState({DateTime? pickupTime})
      : pickupTime =
            pickupTime ?? DateTime.now().add(const Duration(minutes: 20));

  final DateTime pickupTime;

  @override
  List<Object> get props => [pickupTime];
}
