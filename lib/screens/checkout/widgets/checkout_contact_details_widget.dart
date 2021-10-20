import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class CheckoutContactDetailsWidget extends StatefulWidget {
  const CheckoutContactDetailsWidget({Key? key}) : super(key: key);

  @override
  _CheckoutContactDetailsWidgetState createState() =>
      _CheckoutContactDetailsWidgetState();
}

class _CheckoutContactDetailsWidgetState
    extends State<CheckoutContactDetailsWidget> {
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckoutHeaderRowWidget(
          header: 'Contact details',
          onPressed: () {},
          buttonText: '',
          disableButton: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              AlpacaTextField(
                hintText: 'Phone number',
                textController: _phoneNumberController,
                validator: (value) {},
              )
            ],
          ),
        )
      ],
    );
  }
}
