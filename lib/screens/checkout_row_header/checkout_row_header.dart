import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class CheckoutRowHeader extends StatelessWidget {
  const CheckoutRowHeader({
    Key? key,
    required this.header,
    required this.onPressed,
    required this.buttonText,
    this.icon,
    this.buttonKey,
    this.disableButton = false,
    this.buttonBackground = true,
    this.disableButtonBackground = false,
  }) : super(key: key);

  final String header;
  final void Function() onPressed;
  final String buttonText;
  final Widget? icon;
  final bool disableButton;
  final bool buttonBackground;
  final bool disableButtonBackground;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              header,
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: AlpacaColor.darkNavyColor,
                  ),
            ),
          ),
          if (!disableButton)
            AlpacaCheckoutButton(
              key: buttonKey,
              onPressed: onPressed,
              buttonText: buttonText,
              disableButtonBackground: disableButtonBackground,
              svgPicture: icon,
            )
        ],
      ),
    );
  }
}
