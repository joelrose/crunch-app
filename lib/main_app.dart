import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/shared/routes.dart' as routes;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationRepository = AuthenticationRepository();
    final _oneSignalRepository = OneSignalRepository(
      authenticationRepository: _authenticationRepository,
    );
    final _hermesRepository = HermesRepository(
      apiUrl: dotenv.get('API_URL'),
      authenticationRepository: _authenticationRepository,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _oneSignalRepository),
        RepositoryProvider.value(value: _hermesRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DiscoverCubit(
            context.read<HermesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes.Router.generateRoute,
        initialRoute: LoadingScreen.route,
        theme: getThemeData(),
        navigatorObservers: <NavigatorObserver>[observer],
        builder: EasyLoading.init(),
      ),
    );
  }
}
