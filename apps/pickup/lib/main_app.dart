import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:pickup/shared/routes.dart' as routes;

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Future<FirebaseApp> _initalization = Firebase.initializeApp();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
            navigatorObservers: <NavigatorObserver>[observer],
          );
        }

        return Container();
      },
    );
  }
}
