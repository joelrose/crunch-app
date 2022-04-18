import 'package:alpaca/alpaca.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/models/models.dart';
import 'package:pickup/screens/checkout/widgets/widgets.dart';
import 'package:pickup/screens/checkout_cart_items/checkout_cart_items.dart';
import 'package:pickup/screens/checkout_confirmation/checkout_confirmation.dart';
import 'package:pickup/screens/checkout_time_picker/checkout_pickup_widget.dart';
import 'package:pickup/screens/store/model/model.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/show_async_loading.dart';

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

  Future<String?> _getPaymentIntent() async {
    final hermesService = locator<HermesService>();

    final response = await hermesService.client.apiOrdersPost(
      body: CreateOrderRequestDto(
        merchantId: widget.data.merchantId,
        items: widget.data.checkoutItems,
      ),
    );

    if (response.isSuccessful) {
      return response.body!.clientSecret!;
    }

    return null;
  }

  Future<void> _checkout() async {
    final paymentIntentSecret = await _getPaymentIntent();

    if (paymentIntentSecret == null) {
      final snackBar = SnackBar(
        content: Text(context.l10n.connectionPaymentFail),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    try {
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
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
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
            LoadingUtils.asyncLoading(
              _checkout(),
            );
          },
          buttonText: context.l10n.buttonPayLabel,
        ),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        CheckoutOrderNavbarWidget(
          storeName: widget.data.storeName,
          pageOverviewName: context.l10n.orderOverview,
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
    );
  }
}
