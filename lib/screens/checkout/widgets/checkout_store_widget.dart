import 'package:alpaca/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutStoreDirectionWidget extends StatelessWidget {
  const CheckoutStoreDirectionWidget({
    Key? key,
    required this.googleMaps,
  }) : super(key: key);

  final String googleMaps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: 'Store',
          onPressed: () async {
            await launch(googleMaps);
          },
          buttonText: 'Get directions ->',
          disableButtonBackground: true,
        ),
        const DividerWidget(),
      ],
    );
  }
}
