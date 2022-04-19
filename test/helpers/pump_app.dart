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

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockHermesRepository extends Mock implements HermesRepository {}

class MockOneSignalRepository extends Mock implements OneSignalRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    AuthenticationRepository? authenticationRepository,
    OneSignalRepository? oneSignalRepository,
    HermesRepository? hermesRepository,
    DiscoverCubit? discoverCubit,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    final _authenticationRepository = MockAuthenticationRepository();
    final _oneSignalRepository = MockOneSignalRepository();
    final _hermesRepository = MockHermesRepository();

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
