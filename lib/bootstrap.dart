import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pickup/shared/enum/enviroment.dart';

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

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded(
    () async => runApp(
      await builder(),
    ),
    (error, stackTrace) =>
        FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
