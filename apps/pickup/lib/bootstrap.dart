import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pickup/services/service_locator.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  Enviroment enviroment,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupServiceLocator();

  Stripe.publishableKey =
      'pk_test_51JeoF7K5PYFPbUlONYtwknoqrDB1HsFqettfdPeMNex5vmtVagqUP0TEZrl1HGetRsdRfk3T9RdCG7AdGTE1hH5900uSMF0fYk';
  Stripe.merchantIdentifier = 'Crunch';

  await Stripe.instance.applySettings();

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
