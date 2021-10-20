import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';

class CheckoutOrderNavbarWidget extends StatelessWidget {
  const CheckoutOrderNavbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Order Overview',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: AlpacaColor.blackColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
