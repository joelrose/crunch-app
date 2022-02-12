import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/checkout_confirmation.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/home/widgets/favourites/favourites_detail.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/create/create_account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/screens/profile/profile.dart';
import 'package:pickup/screens/store/product_detail_order/product_details_main.dart';
import 'package:pickup/screens/store/store.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';
import 'package:pickup/shared/models.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoadingScreen.route:
        return CupertinoPageRoute(
          builder: (_) => const LoadingScreen(),
        );
      case OnboardingWelcomeScreen.route:
        return CupertinoPageRoute(
          builder: (_) => const OnboardingWelcomeScreen(),
        );
      case OnboardingExplanationScreen.route:
        return CupertinoPageRoute(
          builder: (_) => OnboardingExplanationScreen(),
        );
      case OnboardingAccountScreen.route:
        final args = settings.arguments! as bool;

        return CupertinoPageRoute(
          builder: (_) => OnboardingAccountScreen(isSignUp: args),
        );
      case OnboardingCreateAccountScreen.route:
        final args = settings.arguments! as CreateAccountData;
        return CupertinoPageRoute(
          builder: (_) => OnboardingCreateAccountScreen(data: args),
        );
      case HomeScreen.route:
        return PageRouteBuilder(pageBuilder: (c, a1, a2) => const HomeScreen());
      case ProfileScreen.route:
        return CupertinoPageRoute(builder: (_) => const ProfileScreen());
      case StoreScreen.route:
        final args = settings.arguments! as String;
        return CupertinoPageRoute(
          builder: (_) => StoreScreen(storeId: args),
        );
      case CheckoutScreen.route:
        final args = settings.arguments! as CreateStoreData;
        return CupertinoPageRoute(
          builder: (_) => CheckoutScreen(data: args),
        );
      case CheckoutConfirmationScreen.route:
        final args = settings.arguments! as CreateCheckoutData;
        return CupertinoPageRoute(
          builder: (_) => CheckoutConfirmationScreen(data: args),
        );
      case StoreProductOverview.route:
        final args = settings.arguments! as ProductDetailsData;
        return CupertinoPageRoute(
          builder: (_) => StoreProductOverview(
            data: args,
          ),
        );
      case FavouritesDetail.route:
        return CupertinoPageRoute(
          builder: (context) => FavouritesDetail(),
        );
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
