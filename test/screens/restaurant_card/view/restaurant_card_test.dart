import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pickup/screens/restaurant_card/restaurant_card.dart';
import 'package:pickup/screens/store/store.dart';

import '../../../helpers/pump_app.dart';

final GetStoresOverviewResponse mockRestaurantModel = GetStoresOverviewResponse(
  name: 'test',
  imageUrl: 'https://picsum.photos/250?image=9',
  id: '879398514',
  averagePickupTime: 15,
  averageReview: 4.5,
  reviewCount: 10,
);

void main() {
  testWidgets('restaurant card widget loads', (WidgetTester tester) async {
    // renders
    await mockNetworkImages(
      () => tester.pumpApp(
        RestaurantCard(restaurant: mockRestaurantModel),
      ),
    );
    // pick up time
    final timeFinder = find.text('15 min');
    final ratingFinder = find.text('4.5');

    expect(timeFinder, findsOneWidget);
    expect(ratingFinder, findsOneWidget);
  });

  testWidgets('restaurant card navigates on tap', (WidgetTester tester) async {
    final navigator = MockNavigator();

    when(
      () => navigator.pushNamed<Object?>(
        any(),
        arguments: mockRestaurantModel.id,
      ),
    ).thenAnswer((_) async {
      return null;
    });

    await mockNetworkImages(
      () => tester.pumpApp(
        RestaurantCard(restaurant: mockRestaurantModel),
        navigator: navigator,
      ),
    );

    await tester.pumpAndSettle();

    final card = find.byKey(
      const Key('restaurant_card'),
    );

    expect(card, findsOneWidget);

    await tester.tap(card);
    await tester.pumpAndSettle();

    verify(
      () => navigator.pushNamed<Object?>(
        StorePage.route,
        arguments: mockRestaurantModel.id,
      ),
    ).called(1);
  });
}
