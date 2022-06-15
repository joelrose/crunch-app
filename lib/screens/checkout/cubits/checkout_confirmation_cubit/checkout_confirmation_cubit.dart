import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_confirmation_state.dart';

class CheckoutConfirmationCubit extends Cubit<CheckoutConfirmationState> {
  CheckoutConfirmationCubit({
    required DateTime pickupTime,
    required String googleMapsLink,
  }) : super(
          CheckoutConfirmationState(
            pickupTime: pickupTime,
            googleMapsLink: googleMapsLink,
          ),
        );
}
