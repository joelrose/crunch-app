import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:flutter/material.dart';

class CheckoutStoreDirectionWidget extends StatelessWidget {
  const CheckoutStoreDirectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutHeaderRowWidget(
      header: 'Store',
      onPressed: () {},
      buttonText: 'Get directions ->',
      disableButtonBackground: true,
    );
  }
}
