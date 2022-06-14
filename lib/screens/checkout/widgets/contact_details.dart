import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
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
        CheckoutRowHeader(
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
