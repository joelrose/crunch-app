import 'package:alpaca/routes.dart' as routes;
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      child: const AlpacaApp(),
    ),
  );
}

class AlpacaApp extends StatefulWidget {
  const AlpacaApp({Key? key}) : super(key: key);

  @override
  State<AlpacaApp> createState() => _AlpacaAppState();
}

class _AlpacaAppState extends State<AlpacaApp> {
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
          );
        }

        return Container();
      },
    );
  }
}
