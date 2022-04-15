import 'package:alpaca/alpaca.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pickup/screens/loading/loading.dart';

import 'package:pickup/shared/routes.dart' as routes;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes.Router.generateRoute,
      initialRoute: LoadingScreen.route,
      theme: getThemeData(),
      navigatorObservers: <NavigatorObserver>[observer],
      builder: EasyLoading.init(),
    );
  }
}
