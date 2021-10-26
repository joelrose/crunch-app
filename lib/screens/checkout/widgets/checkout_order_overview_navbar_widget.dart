import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';

class CheckoutOrderNavbarWidget extends StatelessWidget {
  const CheckoutOrderNavbarWidget({Key? key, required this.storeName})
      : super(key: key);

  final String storeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Order Overview',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    storeName,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AlpacaColor.darkGreyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                  ),
                )
              ],
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
          ),
          Positioned(
            right: 0,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Edit',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
