import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:stripe_repository/stripe_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockHermesRepository extends Mock implements HermesRepository {}

class MockOneSignalRepository extends Mock implements OneSignalRepository {}

class MockStripeRepository extends Mock implements StripeRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    AuthenticationRepository? authenticationRepository,
    OneSignalRepository? oneSignalRepository,
    HermesRepository? hermesRepository,
    StripeRepository? stripeRepository,
    DiscoverCubit? discoverCubit,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    final _authenticationRepository = MockAuthenticationRepository();
    final _oneSignalRepository = MockOneSignalRepository();
    final _hermesRepository = MockHermesRepository();
    final _stripeRepository = MockStripeRepository();

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationRepository ?? _authenticationRepository,
          ),
          RepositoryProvider.value(
            value: oneSignalRepository ?? _oneSignalRepository,
          ),
          RepositoryProvider.value(
            value: hermesRepository ?? _hermesRepository,
          ),
          RepositoryProvider.value(
            value: stripeRepository ?? _stripeRepository,
          ),
        ],
        child: BlocProvider(
          create: (context) =>
              discoverCubit ?? DiscoverCubit(_hermesRepository),
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: getThemeData(),
            home: navigator == null
                ? innerChild
                : MockNavigatorProvider(
                    navigator: navigator,
                    child: innerChild,
                  ),
          ),
        ),
      ),
    );
  }
}
