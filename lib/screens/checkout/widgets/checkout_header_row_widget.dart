import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutHeaderRowWidget extends StatelessWidget {
  const CheckoutHeaderRowWidget({
    Key? key,
    required this.header,
    required this.onPressed,
    required this.buttonText,
    this.disableButton = false,
    this.buttonBackground = true,
    this.disableButtonBackground = false,
  }) : super(key: key);

  final String header;
  final void Function() onPressed;
  final String buttonText;
  final bool disableButton;
  final bool buttonBackground;
  final bool disableButtonBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style:
                Theme.of(context).textTheme.headline2?.copyWith(fontSize: 18),
          ),
          disableButton
              ? Container()
              : AlpacaCheckoutButton(
                  onPressed: onPressed,
                  buttonText: buttonText,
                  disableButtonBackground: disableButtonBackground,
                )
        ],
      ),
    );
  }
}
