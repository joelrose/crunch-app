import 'package:alpaca/alpaca.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pickup/routes.dart';
import 'package:pickup/screens/checkout/widgets/checkout_cart_items_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_contact_details_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_order_overview_navbar_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_order_summary_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_pickup_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_store_widget.dart';
import 'package:pickup/screens/store/store.dart';
import 'package:sanity/sanity.dart';

class CreateCheckoutData {
  CreateCheckoutData({
    required this.checkoutItems,
    required this.googleMaps,
    required this.pickupTime,
    required this.creationTime,
  });

  final List<RestaurantMenueItemModel> checkoutItems;
  final String googleMaps;
  final DateTime pickupTime;
  final DateTime creationTime;
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CreateStoreData data;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  num _getTotalPrice() {
    num sum = 0;
    for (final item in widget.data.checkoutItems) {
      sum += item.price;
    }
    return sum;
  }

  Future<String> _getPaymentIntent() async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('createPaymentIntent');

    final results = await callable.call(<String, dynamic>{
      'price': _getTotalPrice(),
    });

    final responseJson = results.data['secret'];

    return responseJson as String;
  }

  Future<void> _checkout() async {
    final paymentIntentSecret = await _getPaymentIntent();

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: 'DE',
        merchantDisplayName: 'Crunch',
        paymentIntentClientSecret: paymentIntentSecret,
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();

      Navigator.of(context).pushNamed(
        storeCheckoutConfirmationRoute,
        arguments: CreateCheckoutData(
          checkoutItems: widget.data.checkoutItems,
          googleMaps: widget.data.googleMaps,
          pickupTime: pickupTimeAsDateTime,
          creationTime: DateTime.now(),
        ),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      statusBarStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AlpacaColor.white100Color,
      floatingActionButtonWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ActionButton(
          onPressed: () {
            _checkout();
          },
          buttonText: 'Pay now',
        ),
      ),
      child: Column(
        children: [
          CheckoutOrderNavbarWidget(
            storeName: widget.data.storeName,
            pageOverviewName: 'Order Overview',
          ),
          Flexible(
            child: ListView(
              children: [
                CheckoutCartItemsWidget(
                  checkoutItems: widget.data.checkoutItems,
                ),
                CheckoutPickupWidget(),
                CheckoutStoreDirectionWidget(
                  googleMaps: widget.data.googleMaps,
                ),
                const CheckoutContactDetailsWidget(),
                CheckoutOrderSummaryWidget(
                  checkoutItems: widget.data.checkoutItems,
                ),
                Container(
                  height: 65,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
