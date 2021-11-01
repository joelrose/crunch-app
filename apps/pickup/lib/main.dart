import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:pickup/routes.dart' as routes;
import 'package:pickup/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupServiceLocator();

  Stripe.publishableKey =
      'pk_test_51JeoF7K5PYFPbUlONYtwknoqrDB1HsFqettfdPeMNex5vmtVagqUP0TEZrl1HGetRsdRfk3T9RdCG7AdGTE1hH5900uSMF0fYk';
  Stripe.merchantIdentifier = 'Crunch';

  await Stripe.instance.applySettings();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Future<FirebaseApp> _initalization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initalization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('App could not be initalized');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: routes.Router.generateRoute,
            initialRoute: routes.loadingRoute,
            theme: getThemeData(context),
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
            ],
          );
        }

        return Container();
      },
    );
  }
}
