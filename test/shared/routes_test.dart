import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/models/models.dart';
import 'package:pickup/screens/checkout_confirmation/checkout_confirmation.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/screens/onboarding/account/account.dart';
import 'package:pickup/screens/onboarding/create_account/create_account.dart';
import 'package:pickup/screens/onboarding/explanation/explanation.dart';
import 'package:pickup/screens/onboarding/welcome/welcome.dart';
import 'package:pickup/screens/restaurant_detail/restaurant_detail.dart';
import 'package:pickup/screens/store/store.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';
import 'package:pickup/shared/models/create_account_model.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:pickup/shared/routes.dart' as routes;
import 'package:test/test.dart';

final List<RouteSettings> routeList = [
  const RouteSettings(name: LoadingScreen.route),
  const RouteSettings(name: OnboardingWelcomeScreen.route),
  const RouteSettings(name: OnboardingExplanationScreen.route),
  const RouteSettings(name: OnboardingAccountScreen.route, arguments: true),
  RouteSettings(
    name: OnboardingCreateAccountScreen.route,
    arguments: CreateAccountData(
      isSocialLogin: false,
    ),
  ),
  const RouteSettings(name: StoreScreen.route, arguments: ''),
  RouteSettings(
    name: CheckoutScreen.route,
    arguments: CreateStoreData(
        checkoutItems: [], googleMaps: '', merchantId: '', storeName: ''),
  ),
  RouteSettings(
    name: CheckoutConfirmationScreen.route,
    arguments: CreateCheckoutData(
      checkoutItems: [],
      creationTime: DateTime.now(),
      googleMaps: '',
      pickupTime: DateTime.now(),
    ),
  ),
  RouteSettings(
    name: StoreDetailPage.route,
    arguments: ProductDetailsData(
      checkoutItems: [],
      item: DeliverectProductModelDto(),
      onCheckoutChange: (_) {},
      restaurantImage: '',
    ),
  ),
  const RouteSettings(name: RestaurantDetailView.route),
];

void main() {
  group('Router', () {
    test(
      'routes all routes',
      () async {
        for (final route in routeList) {
          expect(
            routes.Router.generateRoute(route),
            isA<CupertinoPageRoute<void>>(),
          );
        }
      },
    );
    test(
      'routes HomePage',
      () async {
        expect(
          routes.Router.generateRoute(
            const RouteSettings(name: HomePage.route),
          ),
          isA<PageRouteBuilder<void>>(),
        );
      },
    );

    test(
      'routes non existent route',
      () async {
        const _chars =
            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        final _rnd = Random();

        String getRandomString(int length) => String.fromCharCodes(
              Iterable.generate(
                length,
                (_) => _chars.codeUnitAt(
                  _rnd.nextInt(_chars.length),
                ),
              ),
            );

        expect(
          routes.Router.generateRoute(
            RouteSettings(name: getRandomString(15)),
          ),
          isA<CupertinoPageRoute<void>>(),
        );
      },
    );
  });
}
