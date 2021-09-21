import 'package:alpaca/screens/home/home.dart';
import 'package:alpaca/screens/loading/loading.dart';
import 'package:alpaca/screens/onboarding/create_account.dart';
import 'package:alpaca/screens/onboarding/get_started.dart';
import 'package:alpaca/screens/onboarding/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String loadingRoute = '/';
const String startRoute = '/onboarding/start';
const String welcomeRoute = '/onboarding/welcome';
const String createAccountRoute = '/onboarding/createAccount';
const String homeRoute = '/home';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loadingRoute:
        return CupertinoPageRoute(builder: (_) => const LoadingScreen());
      case startRoute:
        return CupertinoPageRoute(builder: (_) => const GetStartedScreen());
      case welcomeRoute:
        return CupertinoPageRoute(builder: (_) => const WelcomeScreen());
      case createAccountRoute:
        return CupertinoPageRoute(builder: (_) => const CreateAccountScreen());
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
