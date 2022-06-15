import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:checkout_repository/checkout_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:local_storage_checkout_api/local_storage_checkout_api.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/enum/enviroment.dart';
import 'package:stripe_repository/stripe_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName:
        'assets/enviroments/.env.${Enviroment.development.toString().split('.').last}',
  );

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
    () async => BlocOverrides.runZoned(
      () async => runApp(
        App(
          authenticationRepository: _authenticationRepository,
          checkoutRepository: _checkoutRepository,
          oneSignalRepository: _oneSignalRepository,
          hermesRepository: _hermesRepository,
          stripeRepository: _stripeRepository,
        ),
      ),
      blocObserver: AppBlocObserver(),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
