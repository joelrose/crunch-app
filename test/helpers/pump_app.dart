import 'package:alpaca/alpaca.dart';
import 'package:app_outdated_repository/app_outdated_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:checkout_repository/checkout_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/screens/app/bloc/app_outdated/app_outdated_bloc.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:stripe_repository/stripe_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockHermesRepository extends Mock implements HermesRepository {}

class MockOneSignalRepository extends Mock implements OneSignalRepository {}

class MockStripeRepository extends Mock implements StripeRepository {}

class MockCheckoutRepository extends Mock implements CheckoutRepository {}

class MockAppOutdatedRepository extends Mock implements AppOutdatedRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    AuthenticationRepository? authenticationRepository,
    OneSignalRepository? oneSignalRepository,
    HermesRepository? hermesRepository,
    StripeRepository? stripeRepository,
    CheckoutRepository? checkoutRepository,
    AppOutdatedRepository? appOutdatedRepository,
    DiscoverCubit? discoverCubit,
    AppOutdatedBloc? appOutdatedBloc,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    final _authenticationRepository = MockAuthenticationRepository();
    final _oneSignalRepository = MockOneSignalRepository();
    final _hermesRepository = MockHermesRepository();
    final _stripeRepository = MockStripeRepository();
    final _checkoutRepository = MockCheckoutRepository();
    final _appOutdatedRepository = MockAppOutdatedRepository();

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
          RepositoryProvider.value(
            value: checkoutRepository ?? _checkoutRepository,
          ),
          RepositoryProvider.value(
            value: appOutdatedRepository ?? _appOutdatedRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CheckoutBasketBloc(
                checkoutRepository: _checkoutRepository,
              ),
            ),
            BlocProvider(
              create: (context) =>
                  discoverCubit ?? DiscoverCubit(_hermesRepository),
            ),
            BlocProvider(
              create: (context) =>
                  appOutdatedBloc ??
                  AppOutdatedBloc(
                    appOutdatedRepository: _appOutdatedRepository,
                  ),
            )
          ],
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
