part of 'checkout_confirmation_cubit.dart';

class CheckoutConfirmationState extends Equatable {
  const CheckoutConfirmationState({
    required this.pickupTime,
    required this.googleMapsLink,
  });

  final DateTime pickupTime;
  final String googleMapsLink;

  @override
  List<Object> get props => [pickupTime, googleMapsLink];
}
