import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/home/home.dart';
import 'package:pickup/screens/loading/loading.dart';
import 'package:pickup/screens/restaurant_detail/restaurant_detail.dart';
import 'package:pickup/screens/store/view/store.dart';
import 'package:pickup/shared/routes.dart' as routes;

final List<RouteSettings> routeList = [
  const RouteSettings(name: LoadingScreen.route),
  const RouteSettings(
    name: StorePage.route,
    arguments: '',
  ),
  const RouteSettings(name: RestaurantDetailPage.route),
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
