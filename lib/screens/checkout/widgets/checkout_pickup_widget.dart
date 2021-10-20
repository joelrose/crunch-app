import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:flutter/material.dart';

class CheckoutPickupWidget extends StatelessWidget {
  const CheckoutPickupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutHeaderRowWidget(
      header: 'Pickup',
      onPressed: () {},
      buttonText: '14:30 (20 min)',
    );
  }
}
