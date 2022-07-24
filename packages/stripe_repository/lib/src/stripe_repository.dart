import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hermes_repository/hermes_repository.dart';

class HermesApiRequestException implements Exception {}

class HermesApiResponseException implements Exception {}

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
    required String merchantId,
    required List<CreateOrderItemDto> checkoutItems,
  }) async {
    final response = await _hermesRepository.client.apiOrdersPost(
      body: CreateOrderRequestDto(
        merchantId: merchantId,
        items: checkoutItems,
      ),
    );

    if (!response.isSuccessful) {
      throw HermesApiRequestException();
    }

    final clientSecret = response.body?.clientSecret;

    if (clientSecret == null) {
      throw HermesApiResponseException();
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: isTestEnvironment,
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
