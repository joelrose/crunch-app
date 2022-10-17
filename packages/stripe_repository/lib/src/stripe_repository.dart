import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hermes_repository/hermes_repository.dart';

class HermesApiRequestException implements Exception {}

class HermesApiResponseException implements Exception {}

class PaymentCancelled implements Exception {}

class PaymentFailed implements Exception {}

class StripeRepository {
  StripeRepository({required HermesRepository hermesRepository})
      : _hermesRepository = hermesRepository;

  final HermesRepository _hermesRepository;

  late final bool isTestEnvironment;

  Future<void> setupStripe({
    required String stripeKey,
    required String merchantIdentifier,
    required bool isTestEnvironment,
  }) async {
    Stripe.publishableKey = stripeKey;
    Stripe.merchantIdentifier = merchantIdentifier;

    this.isTestEnvironment = isTestEnvironment;

    await Stripe.instance.applySettings();
  }

  Future<void> presentPaymentSheet({
    required String storeId,
    required List<OrderItem> checkoutItems,
  }) async {
    final response = await _hermesRepository.client.appV1OrdersPost(
      request: CreateOrderRequest(
        storeId: storeId,
        orderItems: checkoutItems,
      ),
    );

    if (!response.isSuccessful) {
      throw HermesApiRequestException();
    }

    final clientSecret = response.body?.stripeClientSecret;

    if (clientSecret == null) {
      throw HermesApiResponseException();
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: PaymentSheetApplePay(merchantCountryCode: 'DE'),
        googlePay: PaymentSheetGooglePay(
          testEnv: isTestEnvironment,
          merchantCountryCode: 'DE',
        ),
        style: ThemeMode.light,
        merchantDisplayName: 'Crunch',
        paymentIntentClientSecret: clientSecret,
        allowsDelayedPaymentMethods: true,
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (exception) {
      if (exception is StripeException) {
        if (exception.error.code == FailureCode.Canceled) {
          throw PaymentCancelled();
        }
      }

      throw PaymentFailed();
    }
  }
}
