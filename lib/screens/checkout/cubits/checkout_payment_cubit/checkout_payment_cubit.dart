import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:stripe_repository/stripe_repository.dart';

part 'checkout_payment_state.dart';

class CheckoutPaymentCubit extends Cubit<CheckoutPaymentState> {
  CheckoutPaymentCubit({
    required StripeRepository stripeRepository,
    required String storeId,
  })  : _stripeRepository = stripeRepository,
        _storeId = storeId,
        super(const CheckoutPaymentState(PaymentStatus.initial));

  final StripeRepository _stripeRepository;
  final String _storeId;

  Future<void> checkout(
    List<OrderItem> checkoutItems,
  ) async {
    emit(const CheckoutPaymentState(PaymentStatus.loading));

    try {
      await _stripeRepository.presentPaymentSheet(
        storeId: _storeId,
        checkoutItems: checkoutItems,
      );

      emit(const CheckoutPaymentState(PaymentStatus.paid));
    } catch (e) {
      if (e is PaymentCancelled) {
        emit(const CheckoutPaymentState(PaymentStatus.cancelled));
      } else if (e is PaymentFailed) {
        emit(const CheckoutPaymentState(PaymentStatus.failed));
      }
    }
  }
}
