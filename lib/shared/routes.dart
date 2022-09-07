import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/screens/profile/profile.dart';
import 'package:pickup/screens/restaurant_detail/restaurant_detail.dart';
import 'package:pickup/screens/store/store.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoadingScreen.route:
        return CupertinoPageRoute(
          builder: (_) => const LoadingScreen(),
        );
      case HomePage.route:
        return CupertinoPageRoute(builder: (_) => const HomePage());
      case ProfilePage.route:
        return CupertinoPageRoute(builder: (_) => ProfilePage());
      case StorePage.route:
        final args = settings.arguments! as String;
        return CupertinoPageRoute(
          builder: (_) => StorePage(storeId: args),
        );
      case RestaurantDetailPage.route:
        return CupertinoPageRoute(
          builder: (context) => RestaurantDetailPage(),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
