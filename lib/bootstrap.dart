import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pickup/shared/enum/enviroment.dart';

Future setupStripe() async {
  Stripe.publishableKey = dotenv.env['STRIPE_KEY']!;
  Stripe.merchantIdentifier = dotenv.env['STRIPE_MERCHANT_IDENTIFIER'];

  await Stripe.instance.applySettings();
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  Enviroment enviroment,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await dotenv.load(
    fileName:
        'assets/enviroments/.env.${enviroment.toString().split('.').last}',
  );

  await setupStripe();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded(
    () async => runApp(
      await builder(),
    ),
    (error, stackTrace) =>
        FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
