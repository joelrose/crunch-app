import 'package:alpaca/screens/checkout/checkout.dart';
import 'package:alpaca/screens/home/home.dart';
import 'package:alpaca/screens/loading/loading.dart';
import 'package:alpaca/screens/onboarding/account/account.dart';
import 'package:alpaca/screens/onboarding/create/create_account.dart';
import 'package:alpaca/screens/onboarding/explanation/explanation.dart';
import 'package:alpaca/screens/onboarding/welcome/welcome.dart';
import 'package:alpaca/screens/profile/profile.dart';
import 'package:alpaca/screens/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String loadingRoute = '/';
const String onboardingWelcomeRoute = '/onboarding/welcome';
const String onboardingExplanationRoute = '/onboarding/explanation';
const String onboardingAccountRoute = '/onboarding/account';
const String onboardingCreateAccountRoute = '/onboarding/account/create';
const String homeRoute = '/home';
const String profileRoute = '/profile';
const String storeRoute = '/store';
const String storeCheckoutRoute = '/store/checkout';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loadingRoute:
        return CupertinoPageRoute(
          builder: (_) => const LoadingScreen(),
        );
      case onboardingWelcomeRoute:
        return CupertinoPageRoute(
          builder: (_) => const OnboardingWelcomeScreen(),
        );
      case onboardingExplanationRoute:
        return CupertinoPageRoute(
          builder: (_) => const OnboardingExplanationScreen(),
        );
      case onboardingAccountRoute:
        final args = settings.arguments! as bool;

        return CupertinoPageRoute(
          builder: (_) => OnboardingAccountScreen(isSignUp: args),
        );
      case onboardingCreateAccountRoute:
        final args = settings.arguments! as CreateAccountData;
        return CupertinoPageRoute(
          builder: (_) => OnboardingCreateAccountScreen(data: args),
        );
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case profileRoute:
        return CupertinoPageRoute(builder: (_) => const ProfileScreen());
      case storeRoute:
        final args = settings.arguments! as String;
        return CupertinoPageRoute(
          builder: (_) => StoreScreen(storeId: args),
        );
      case storeCheckoutRoute:
        return CupertinoPageRoute(builder: (_) => const CheckoutScreen());
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
