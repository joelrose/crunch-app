import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/checkout/widgets/check_out_items_widget.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';

class CheckoutCartItemsWidget extends StatelessWidget {
  const CheckoutCartItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CreateOrderItemDto> checkoutItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckoutHeaderRowWidget(
          header: 'Cart items',
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: 'Edit',
        ),
        CheckOutItemsWidget(checkoutItems: checkoutItems),
        const AlpacaDivider(),
      ],
    );
  }
}
