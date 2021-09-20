import 'package:alpaca/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getSocialButton(
  String buttonText,
  String assetPath,
  double width, {
  bool backgroundWhite = true,
}) {
  return CupertinoButton(
    onPressed: () => {},
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundWhite ? AlpacaColor.white100Color : Colors.black,
      ),
      child: Row(
        children: <Widget>[
          Container(width: width * 0.18),
          Container(
            width: 40,
            height: 25,
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset(assetPath),
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: backgroundWhite
                  ? const Color.fromRGBO(43, 45, 66, 1)
                  : AlpacaColor.white100Color,
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

class _AlpacaButton extends StatelessWidget {
  const _AlpacaButton({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      disabledColor: Colors.red,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 16,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.isPrimaryButton = true,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final bool isPrimaryButton;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return _AlpacaButton(
      backgroundColor:
          isPrimaryButton ? AlpacaColor.primary100 : AlpacaColor.white100Color,
      textColor:
          isPrimaryButton ? AlpacaColor.white100Color : AlpacaColor.primary100,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }
}
