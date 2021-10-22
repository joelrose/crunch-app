import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/screens/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<RestaurantMenueItemModel> checkoutItems = [];
  testWidgets('Search for top bar: Order Overview ', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Order Overview'), findsOneWidget);
  });

  testWidgets('Search for items Widget', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Cart items'), findsOneWidget);
  });

  testWidgets('Search for Pickup Widget', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Pickup'), findsOneWidget);
  });

  testWidgets('Search for Store Widget', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Store'), findsOneWidget);
  });

  testWidgets('Search for Contact Details Widget', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Contact details'), findsOneWidget);
  });

  testWidgets('Search for Phone number Input', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Phone number'), findsOneWidget);
  });

  testWidgets('Search for Order summary Widget', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Order summary'), findsOneWidget);
  });

  testWidgets('Search for Checkout Button', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: CheckoutScreen(
              checkoutItems: [],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Pay now'), findsOneWidget);
  });
}
