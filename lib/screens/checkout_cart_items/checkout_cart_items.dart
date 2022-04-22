import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
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
          header: context.l10n.checkoutCartItems,
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: context.l10n.edit,
        ),
        CheckOutItemsWidget(checkoutItems: checkoutItems),
        const Divider(),
      ],
    );
  }
}
