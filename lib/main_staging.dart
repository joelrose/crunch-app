import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:checkout_repository/checkout_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
import 'package:local_storage_checkout_api/local_storage_checkout_api.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/enum/enviroment.dart';
import 'package:stripe_repository/stripe_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthenticationRepository.initializeFirebase();

  await dotenv.load(
    fileName:
        'assets/enviroments/.env.${Enviroment.staging.toString().split('.').last}',
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final authenticationRepository = AuthenticationRepository();

  final oneSignalRepository = OneSignalRepository(
    authenticationRepository: authenticationRepository,
  );

  final hermesRepository = HermesRepository(
    apiUrl: dotenv.get('API_URL'),
    authenticationRepository: authenticationRepository,
  );

  final stripeRepository = StripeRepository(
    hermesRepository: hermesRepository,
  );

  final checkoutRepository = CheckoutRepository(
    checkoutApi:
        LocalStorageCheckoutApi(plugin: await SharedPreferences.getInstance()),
  );

  stripeRepository.setupStripe(
    merchantIdentifier: dotenv.env['STRIPE_MERCHANT_IDENTIFIER']!,
    stripeKey: dotenv.env['STRIPE_KEY']!,
    isTestEnvironment: true,
  );

  runZonedGuarded(
    () async => runApp(
      App(
        authenticationRepository: authenticationRepository,
        checkoutRepository: checkoutRepository,
        oneSignalRepository: oneSignalRepository,
        hermesRepository: hermesRepository,
        stripeRepository: stripeRepository,
        loadingOverlayRepository: LoadingOverlayRepository(),
      ),
    ),
    (error, stackTrace) =>
        FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
