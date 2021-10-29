import 'package:alpaca/global.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
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
        const DividerWidget(),
        CheckoutHeaderRowWidget(
          header: 'Contact details',
          onPressed: () {},
          buttonText: '',
          disableButton: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: AlpacaTextField(
                      textColor: AlpacaColor.darkNavyColor,
                      hintText: 'Phone number',
                      textController: _phoneNumberController,
                      validator: (value) {},
                    ),
                  ),
                  Text(
                    '''Providing a phone number allows the restaurant to contact you easily in case there is an issue with your order.''',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: AlpacaColor.darkGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
        const DividerWidget(),
      ],
    );
  }
}
