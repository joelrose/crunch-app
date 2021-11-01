import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pickup/global.dart';

Widget getSocialButton(
  String buttonText,
  String assetPath,
  double width,
  void Function() onPressed, {
  bool backgroundWhite = true,
}) {
  return CupertinoButton(
    onPressed: onPressed,
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
    this.textColor,
  }) : super(key: key);

  final bool isPrimaryButton;
  final String buttonText;
  final void Function() onPressed;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return _AlpacaButton(
      textColor: textColor ??
          (isPrimaryButton
              ? AlpacaColor.white100Color
              : AlpacaColor.primary100),
      backgroundColor:
          isPrimaryButton ? AlpacaColor.primary100 : AlpacaColor.white100Color,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }
}

class AlpacaIconButton extends StatelessWidget {
  const AlpacaIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final void Function() onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              AlpacaColor.primary100,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              AlpacaColor.white100Color,
            ),
          ),
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        ),
      ),
    );
  }
}

class AlpacaTextField extends StatelessWidget {
  const AlpacaTextField({
    Key? key,
    required this.hintText,
    required this.textController,
    required this.validator,
    this.fillColor = AlpacaColor.lightGreyColor90,
    this.hintTextColor = AlpacaColor.lightGreyColor100,
    this.textColor = AlpacaColor.blackColor,
    this.cursorColor = AlpacaColor.blackColor,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  final String hintText;
  final Color fillColor;
  final Color hintTextColor;
  final Color textColor;
  final Color cursorColor;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController textController;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Text(
            hintText,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
          ),
        ),
        TextFormField(
          controller: textController,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          autocorrect: false,
          cursorColor: cursorColor,
          obscureText: obscureText,
          style: TextStyle(
            color: textColor,
          ),
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: fillColor,
              ),
            ),
            fillColor: AlpacaColor.white100Color,
            hintText: hintText,
            filled: true,
            hintStyle: TextStyle(
              color: hintTextColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: fillColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: fillColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class AlpacaCheckoutButton extends StatelessWidget {
  const AlpacaCheckoutButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.disableButtonBackground = false,
  }) : super(key: key);

  final void Function() onPressed;
  final String buttonText;
  final bool disableButtonBackground;

  @override
  Widget build(BuildContext context) {
    final buttonBackground =
        !disableButtonBackground ? const Color(0xffF6F0FF) : Colors.transparent;
    return TextButton(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          backgroundColor: buttonBackground),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: AlpacaColor.primary80,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class AlpacaTextFieldWithLabel extends StatelessWidget {
  const AlpacaTextFieldWithLabel({
    Key? key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
    this.expands = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          expands: expands,
          style: const TextStyle(color: AlpacaColor.blackColor),
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            labelText: labelText,
            alignLabelWithHint: true,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class AlpacaClosePopUpWindownButton extends StatelessWidget {
  const AlpacaClosePopUpWindownButton({Key? key, required this.onPressed})
      : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AlpacaColor.lightGreyColor90,
      radius: 16,
      child: IconButton(
        iconSize: 20,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(Icons.close_rounded),
        color: AlpacaColor.darkGreyColor,
      ),
    );
  }
}
