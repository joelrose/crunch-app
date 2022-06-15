import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddressDirection extends StatelessWidget {
  const AddressDirection({Key? key, required this.googleMapsLink})
      : super(key: key);

  final String googleMapsLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerWidget(),
        CheckoutRowHeader(
          header: context.l10n.store,
          onPressed: () async {
            await launchUrlString(googleMapsLink);
          },
          buttonText: context.l10n.directionsButtonLabel,
          disableButtonBackground: true,
        ),
        const DividerWidget(),
      ],
    );
  }
}
