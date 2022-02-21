import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/store/store.dart';

void main() {
  testWidgets('Search for top bar: Order Overview ', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Order Overview'), findsOneWidget);
    });
  });

  testWidgets('Search for items Widget', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Cart items'), findsOneWidget);
    });
  });

  testWidgets('Search for Pickup Widget', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
        const Duration(seconds: 1),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Pickup'), findsOneWidget);
    });
  });

  testWidgets('Search for Store Widget', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Store'), findsOneWidget);
    });
  });

  testWidgets('Search for Contact Details Widget', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
        const Duration(seconds: 1),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Contact details'), findsOneWidget);
    });
  });

  testWidgets('Search for Phone number Input', (tester) async {
    // await tester.pumpWidget(
    //   MediaQuery(
    //     data: const MediaQueryData(),
    //     child: MaterialApp(
    //       home: Scaffold(
    //         body: CheckoutScreen(
    //           data: CreateStoreData(
    //               checkoutItems: [], storeName: '', googleMaps: ''),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // expect(find.text('Phone number'), findsOneWidget);
  });

  testWidgets('Search for Order summary Widget', (tester) async {
    // await tester.pumpWidget(
    //   MediaQuery(
    //     data: const MediaQueryData(),
    //     child: MaterialApp(
    //       home: Scaffold(
    //         body: CheckoutScreen(
    //           data: CreateStoreData(
    //               checkoutItems: [], storeName: '', googleMaps: ''),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // expect(find.text('Order summary'), findsOneWidget);
  });

  testWidgets('Search for Checkout Button', (tester) async {
    fakeAsync((async) {
      tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: CheckoutScreen(
                data: CreateStoreData(
                  checkoutItems: [],
                  storeName: '',
                  googleMaps: '',
                ),
              ),
            ),
          ),
        ),
      );
      async.elapse(const Duration(seconds: 1));

      expect(find.text('Pay now'), findsOneWidget);
    });
  });
}
