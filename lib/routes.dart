import 'package:alpaca/screens/onboarding/create_account.dart';
import 'package:alpaca/screens/onboarding/get_started.dart';
import 'package:alpaca/screens/onboarding/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String startRoute = '/';
const String welcomeRoute = '/onboarding/welcome';
const String createAccountRoute = '/onboarding/createAccount';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startRoute:
        return CupertinoPageRoute(builder: (_) => const GetStartedScreen());
      case welcomeRoute:
        return CupertinoPageRoute(builder: (_) => const WelcomeScreen());
      case createAccountRoute:
        return CupertinoPageRoute(builder: (_) => const CreateAccountScreen());
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
