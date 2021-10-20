import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/screens/checkout/widgets/cart_items_widget.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
import 'package:alpaca/screens/checkout/widgets/order_overview_navbar_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<RestaurantMenueItemModel> checkoutItems;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  num _getTotalPrice() {
    num sum = 0;
    for (final RestaurantMenueItemModel item in widget.checkoutItems) {
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

      Navigator.of(context).pushNamed(storeCheckoutConfirmationRoute);
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
          const order_navbar_widget(),
          const divider_widget(),
          cart_items_widget(checkoutItems: widget.checkoutItems),
        ],
      ),
    );
  }
}
