import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
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
  const CheckoutConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: ListView(
        children: [
          CheckoutOrderNavbarWidget(
            pageOverviewName: 'Order status',
            disableEditButton: true,
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              Container(
                color: AlpacaColor.primary100.withOpacity(0.03),
                height: 151,
                child: Center(
                  child: Text(
                    '22 min',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontSize: 51,
                        color: AlpacaColor.primary100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              CheckoutHeaderRowWidget(
                header: 'Order details',
                onPressed: () {},
                buttonText: '',
                disableButton: true,
              )
            ],
          )
        ],
      ),
    );
  }
}
