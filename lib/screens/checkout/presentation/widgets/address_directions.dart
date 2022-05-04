import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout/presentation/widgets/divider_widget.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../cubits/cubit.dart';


class AddressDirection extends StatelessWidget {
  const AddressDirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleMaps = context
        .select((CheckoutCubit cubit) => cubit.state.menu.googleMapsLink)!;

    return Column(
      children: [
        const DividerWidget(),
        CheckoutRowHeader(
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
