import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
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
      child: Column(
        children: [
          CheckoutOrderNavbarWidget(
            pageOverviewName: 'Order status',
            disableEditButton: true,
          )
        ],
      ),
    );
  }
}
