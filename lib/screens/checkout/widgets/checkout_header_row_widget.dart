import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class checkout_header_row_widget extends StatelessWidget {
  const checkout_header_row_widget({
    Key? key,
    required this.header,
    required this.onPressed,
  }) : super(key: key);

  final String header;
  final void Function() onPressed;

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
          AlpacaCheckoutButton(
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
