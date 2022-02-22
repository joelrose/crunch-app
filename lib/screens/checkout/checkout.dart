import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';
import 'package:pickup/screens/checkout/checkout_confirmation.dart';
import 'package:pickup/screens/checkout/widgets/checkout_cart_items_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_contact_details_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_order_overview_navbar_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_order_summary_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_pickup_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_store_widget.dart';
import 'package:pickup/screens/store/store.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/show_async_loading.dart';
import 'package:sanity/sanity.dart';

class CreateCheckoutData {
  CreateCheckoutData({
    required this.checkoutItems,
    required this.googleMaps,
    required this.pickupTime,
    required this.creationTime,
  });

  final List<CheckoutItemModel> checkoutItems;
  final String googleMaps;
  final DateTime pickupTime;
  final DateTime creationTime;
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  static const route = '/store/checkout';

  final CreateStoreData data;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late DateTime pickupTime;

  @override
  void initState() {
    super.initState();
    pickupTime = DateTime.now().add(const Duration(minutes: 20));
  }

  void getPickupTime(DateTime newPickupTime) {
    setState(() {
      pickupTime = newPickupTime;
    });
  }

  Future<String> _getPaymentIntent() async {
    final hermesService = locator<HermesService>();

    final response = await hermesService.client.apiOrdersPost(
      body: CreateOrderRequestDto(
        storeId: widget.data.storeName,
        price: widget.data.checkoutItems.getTotalPrice().toDouble(),
        items: [],
      ),
    );

    return response.body!.clientSecret!;
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

      if (mounted) {
        Navigator.of(context).pushNamed(
          CheckoutConfirmationScreen.route,
          arguments: CreateCheckoutData(
            checkoutItems: widget.data.checkoutItems,
            googleMaps: widget.data.googleMaps,
            pickupTime: pickupTime,
            creationTime: DateTime.now(),
          ),
        );
      } 
    } catch (e) {
      print(e);
    }
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
            showAsyncLoading(
              context,
              _checkout(),
            );
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
                CheckoutPickupWidget(
                  getPickupTime: getPickupTime,
                ),
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
