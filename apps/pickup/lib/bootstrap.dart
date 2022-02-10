import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/enviroment.dart';

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

  await EasyLocalization.ensureInitialized();

  await dotenv.load(
    fileName:
        'assets/enviroments/.env.${enviroment.toString().split('.').last}',
  );

  await setupServiceLocator();

  await setupStripe();

  runZonedGuarded(
    () async => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        useOnlyLangCode: true,
        child: await builder(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
