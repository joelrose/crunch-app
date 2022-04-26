import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hermes_repository/hermes_repository.dart';

class HermesApiRequestException implements Exception {}

class HermesApiResponseException implements Exception {}

class StripeRepository {
  StripeRepository({required this.hermesRepository}) {}

  final HermesRepository hermesRepository;

  Future<void> setupStripe({
    required String stripeKey,
    required String merchantIdentifier,
  }) async {
    Stripe.publishableKey = stripeKey;
    Stripe.merchantIdentifier = merchantIdentifier;

    await Stripe.instance.applySettings();
  }

  Future<void> presentPaymentSheet({
    required String merchantId,
    required List<CreateOrderItemDto> checkoutItems,
  }) async {
    final response = await hermesRepository.client.apiOrdersPost(
      body: CreateOrderRequestDto(
        merchantId: merchantId,
        items: checkoutItems,
      ),
    );

    if (!response.isSuccessful) {
      throw HermesApiRequestException();
    }

    final clientSecret = response.body?.clientSecret ?? '';

    if (clientSecret.isEmpty) {
      throw HermesApiResponseException();
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: 'DE',
        merchantDisplayName: 'Crunch',
        paymentIntentClientSecret: clientSecret,
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException {
      rethrow;
    }
  }
}
