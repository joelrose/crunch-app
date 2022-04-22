import 'package:alpaca/alpaca.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/models/models.dart';
import 'package:pickup/screens/checkout/widgets/widgets.dart';
import 'package:pickup/screens/checkout_cart_items/checkout_cart_items.dart';
import 'package:pickup/screens/checkout_confirmation/checkout_confirmation.dart';
import 'package:pickup/screens/checkout_time_picker/checkout_pickup_widget.dart';
import 'package:pickup/screens/store/model/model.dart';
import 'package:pickup/shared/show_async_loading.dart';
import 'package:stripe_repository/stripe_repository.dart';

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
  DateTime pickupTime = DateTime.now().add(const Duration(minutes: 20));

  void getPickupTime(DateTime newPickupTime) {
    setState(() {
      pickupTime = newPickupTime;
    });
  }

  Future<void> _checkout() async {
    final stripeRepository = context.read<StripeRepository>();

    try {
      await stripeRepository.presentPaymentSheet(
        merchantId: widget.data.merchantId,
        checkoutItems: widget.data.checkoutItems,
      );

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
      final snackBar = SnackBar(
        content: Text(context.l10n.connectionPaymentFail),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
