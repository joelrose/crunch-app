import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:checkout_repository/checkout_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/bloc/checkout_basket_bloc.dart';
import 'package:pickup/screens/app/cubit/language/language_cubit.dart';
import 'package:pickup/screens/app/cubit/user/user_cubit.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/shared/routes.dart' as routes;
import 'package:stripe_repository/stripe_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required OneSignalRepository oneSignalRepository,
    required HermesRepository hermesRepository,
    required StripeRepository stripeRepository,
    required CheckoutRepository checkoutRepository,
    required LoadingOverlayRepository loadingOverlayRepository,
  })  : _authenticationRepository = authenticationRepository,
        _oneSignalRepository = oneSignalRepository,
        _hermesRepository = hermesRepository,
        _stripeRepository = stripeRepository,
        _checkoutRepository = checkoutRepository,
        _loadingOverlayRepository = loadingOverlayRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final OneSignalRepository _oneSignalRepository;
  final HermesRepository _hermesRepository;
  final StripeRepository _stripeRepository;
  final CheckoutRepository _checkoutRepository;
  final LoadingOverlayRepository _loadingOverlayRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _oneSignalRepository),
        RepositoryProvider.value(value: _hermesRepository),
        RepositoryProvider.value(value: _stripeRepository),
        RepositoryProvider.value(value: _checkoutRepository),
        RepositoryProvider.value(value: _loadingOverlayRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observer =
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DiscoverCubit(
            context.read<HermesRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckoutBasketBloc(
            checkoutRepository: context.read<CheckoutRepository>(),
          )..add(
              const CheckoutBasketSubscriptionRequested(),
            ),
        ),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(
          create: (context) => UserCubit(
            hermesRepository: context.read<HermesRepository>(),
          ),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: routes.Router.generateRoute,
            initialRoute: LoadingScreen.route,
            theme: getThemeData(),
            navigatorObservers: <NavigatorObserver>[observer],
            builder: context.read<LoadingOverlayRepository>().initialize(),
          );
        },
      ),
    );
  }
}
