import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/checkout/checkout.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_confirmation_time.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_cart_items_widget.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_contact_details_widget.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_order_overview_navbar_widget.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_order_summary_widget.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_pickup_widget.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_store_widget.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
import 'package:alpaca/screens/store/store.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  const CheckoutConfirmationScreen({Key? key, required this.data})
      : super(key: key);

  final CreateCheckoutData data;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          CheckoutOrderNavbarWidget(
            pageOverviewName: 'Order status',
            disableEditButton: true,
          ),
          Flexible(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 230,
                          child: Text(
                            'Your order is being prepared...',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(fontSize: 22),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.checkoutItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              final checkoutItem = data.checkoutItems[i];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '1x ${checkoutItem.title.english}',
                                      style: const TextStyle(
                                        color: AlpacaColor.darkGreyColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '${checkoutItem.price}€',
                                      style: const TextStyle(
                                        color: AlpacaColor.blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        DividerWidget(),
                      ],
                    ),
                    CheckoutStoreDirectionWidget(googleMaps: data.googleMaps)
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
