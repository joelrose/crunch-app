import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pickup/screens/restaurant_card/restaurant_card.dart';
import 'package:pickup/screens/store/store.dart';

import '../../../helpers/pump_app.dart';

final GetMenusResponseDto mockRestaurantModel = GetMenusResponseDto(
  averagePickUpTime: '15',
  menu: DeliverectMenusDto(
    menuImageUrl: 'https://picsum.photos/250?image=9',
    menu: 'test',
  ),
  id: '879398514',
  rating: 4.5,
  reviewCount: '10',
);

void main() {
  testWidgets('restaurant card widget loads', (WidgetTester tester) async {
    // renders
    await mockNetworkImagesFor(
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
    ).thenAnswer((_) async {});

    await mockNetworkImagesFor(
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
      () => navigator.pushNamed<Object?>(StoreScreen.route,
          arguments: mockRestaurantModel.id),
    ).called(1);
  });
}
