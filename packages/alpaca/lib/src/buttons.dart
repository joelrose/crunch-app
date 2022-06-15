import 'package:alpaca/src/bounceable.dart';
import 'package:alpaca/src/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getSocialButton(
  String buttonText,
  double width,
  Widget svgPicture,
  void Function() onPressed, {
  bool backgroundWhite = true,
}) {
  return Bounceable(
    child: CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundWhite ? AlpacaColor.white100Color : Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: svgPicture,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
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
                ),
              ),
            ],
          ),
        ),
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
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
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
    return Bounceable(
      child: _AlpacaButton(
        textColor: textColor ??
            (isPrimaryButton
                ? AlpacaColor.white100Color
                : AlpacaColor.primary100),
        backgroundColor: isPrimaryButton
            ? AlpacaColor.primary100
            : AlpacaColor.white100Color,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
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
    required this.validator,
    this.textController,
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
  final TextEditingController? textController;
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
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AlpacaColor.darkNavyColor),
          ),
        ),
        TextFormField(
          controller: textController,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          autocorrect: false,
          cursorColor: cursorColor,
          obscureText: obscureText,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AlpacaColor.darkNavyColor,
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
    this.svgPicture,
    this.disableButtonBackground = false,
  }) : super(key: key);

  final void Function() onPressed;
  final String buttonText;
  final Widget? svgPicture;
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
          backgroundColor: buttonBackground,),
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AlpacaColor.primary80,
                ),
          ),
          if (svgPicture != null)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: svgPicture,
            )
        ],
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

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key? key,
    required this.buttonText,
    required this.priceText,
    required this.onPressed,
    this.textColor,
  }) : super(key: key);

  final String buttonText;
  final String priceText;
  final void Function() onPressed;

  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: const Duration(milliseconds: 100),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: AlpacaColor.primary100,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8.0),),
                    color: AlpacaColor.primary80,),
                child: Text(
                  priceText,
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
            ],
          ),
        ),
      ),
    );
  }
}
