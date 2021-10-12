import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  const CheckoutConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Order confirmed!',
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ActionButton(
              buttonText: 'Back to overview ->',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(homeRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
