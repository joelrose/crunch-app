import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:stripe_repository/stripe_repository.dart';

part 'checkout_payment_state.dart';

class CheckoutPaymentCubit extends Cubit<CheckoutPaymentState> {
  CheckoutPaymentCubit({
    required StripeRepository stripeRepository,
    required String merchantId,
  })  : _stripeRepository = stripeRepository,
        _merchantId = merchantId,
        super(const CheckoutPaymentState(PaymentStatus.initial));

  final StripeRepository _stripeRepository;
  final String _merchantId;

  Future<void> checkout(
    List<CreateOrderItemDto> checkoutItems,
  ) async {
    emit(const CheckoutPaymentState(PaymentStatus.loading));

    try {
      await _stripeRepository.presentPaymentSheet(
        merchantId: _merchantId,
        checkoutItems: checkoutItems,
      );

      emit(const CheckoutPaymentState(PaymentStatus.paid));
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);

      emit(const CheckoutPaymentState(PaymentStatus.failed));
    }
  }
}
