
import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrdersLoadingView extends StatelessWidget {
  const OrdersLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/under-construction.svg',
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40,
            ),
            child: Text(
              'Hey, we building something great here. Stay tuned!',
              style: Theme.of(context).textTheme.bodyText1!.merge(
                    const TextStyle(
                      color: AlpacaColor.darkGreyColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(height: 100)
        ],
      ),
    );
  }
}
