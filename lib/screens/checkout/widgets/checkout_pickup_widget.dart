import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:flutter/material.dart';

class checkout_pickup_widget extends StatelessWidget {
  const checkout_pickup_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkout_header_row_widget(
      header: 'Pickup',
      onPressed: () {},
      buttonText: '14:30 (20 min)',
    );
  }
}
