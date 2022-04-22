import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';

class CheckoutContactDetailsWidget extends StatefulWidget {
  const CheckoutContactDetailsWidget({Key? key}) : super(key: key);

  @override
  _CheckoutContactDetailsWidgetState createState() =>
      _CheckoutContactDetailsWidgetState();
}

class _CheckoutContactDetailsWidgetState
    extends State<CheckoutContactDetailsWidget> {
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: context.l10n.contactDetails,
          onPressed: () {},
          buttonText: '',
          disableButton: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: AlpacaTextField(
                  textColor: AlpacaColor.darkNavyColor,
                  hintText: context.l10n.mobileNumber,
                  textController: _phoneNumberController,
                  validator: (value) => null,
                ),
              ),
              Text(
                context.l10n.contactDetailsDescription,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
        const DividerWidget(),
      ],
    );
  }
}
