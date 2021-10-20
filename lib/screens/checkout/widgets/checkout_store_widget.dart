import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:flutter/material.dart';

class checkout_store_direction_widget extends StatelessWidget {
  const checkout_store_direction_widget({Key? key}) : super(key: key);

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
