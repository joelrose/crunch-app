import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          header: context.l10n.store,
          onPressed: () async {
            await launchUrlString(googleMaps);
          },
          buttonText: context.l10n.directionsButtonLabel,
          disableButtonBackground: true,
        ),
        const DividerWidget(),
      ],
    );
  }
}
