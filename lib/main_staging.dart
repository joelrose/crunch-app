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

  await dotenv.load(
    fileName:
        'assets/enviroments/.env.${Enviroment.staging.toString().split('.').last}',
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final _authenticationRepository = AuthenticationRepository();

  await _authenticationRepository.initializeFirebase();

  final _oneSignalRepository = OneSignalRepository(
    authenticationRepository: _authenticationRepository,
  );

  final _hermesRepository = HermesRepository(
    apiUrl: dotenv.get('API_URL'),
    authenticationRepository: _authenticationRepository,
  );

  final _stripeRepository = StripeRepository(
    hermesRepository: _hermesRepository,
  );

  final _checkoutRepository = CheckoutRepository(
    checkoutApi:
        LocalStorageCheckoutApi(plugin: await SharedPreferences.getInstance()),
  );

  _stripeRepository.setupStripe(
    merchantIdentifier: dotenv.env['STRIPE_MERCHANT_IDENTIFIER']!,
    stripeKey: dotenv.env['STRIPE_KEY']!,
  );

  runZonedGuarded(
    () async => runApp(
      App(
        authenticationRepository: _authenticationRepository,
        checkoutRepository: _checkoutRepository,
        oneSignalRepository: _oneSignalRepository,
        hermesRepository: _hermesRepository,
        stripeRepository: _stripeRepository,
        loadingOverlayRepository: LoadingOverlayRepository(),
      ),
    ),
    (error, stackTrace) =>
        FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
