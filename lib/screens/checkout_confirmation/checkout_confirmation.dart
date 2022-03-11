import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/checkout/models/models.dart';
import 'package:pickup/screens/checkout/widgets/check_out_items_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_order_overview_navbar_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_store_widget.dart';
import 'package:pickup/screens/checkout_confirmation/checkout_confirmation_time.dart';
import 'package:pickup/screens/home/home.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  const CheckoutConfirmationScreen({Key? key, required this.data})
      : super(key: key);

  static const route = '/store/checkout/confirmation';

  final CreateCheckoutData data;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          const CheckoutOrderNavbarWidget(
            pageOverviewName: 'Order status',
            showBackButton: false,
          ),
          Flexible(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 230,
                          child: Text(
                            'Your order is being prepared...',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                    ),
                    const LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: AlpacaColor.primary100,
                    ),
                    Container(
                      color: AlpacaColor.primary100.withOpacity(0.03),
                      height: 151,
                      child: Center(
                        child: CheckoutConfirmationTime(
                          pickupTime: data.pickupTime,
                        ),
                      ),
                    ),
                    CheckoutHeaderRowWidget(
                      header: 'Order details',
                      onPressed: () {},
                      buttonText: '',
                      disableButton: true,
                    ),
                    CheckOutItemsWidget(checkoutItems: data.checkoutItems),
                    CheckoutStoreDirectionWidget(googleMaps: data.googleMaps),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: ActionButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.route,
                            (Route<dynamic> route) => false,
                          );
                        },
                        buttonText: 'Continue',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
