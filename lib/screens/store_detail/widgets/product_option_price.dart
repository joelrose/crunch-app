import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/shared/utilities.dart';

class ProductOptionPrice extends StatelessWidget {
  const ProductOptionPrice({
    Key? key,
    required this.name,
    required this.price,
    required this.isSnoozed,
  }) : super(key: key);

  final String name;
  final int price;
  final bool isSnoozed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AlpacaColor.darkNavyColor,
                    decoration: isSnoozed ? TextDecoration.lineThrough : null,
                  ),
            ),
            if (price != 0)
              Text(
                '+${Utilities.currencyFormat(price)}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.primary100,
                      decoration: isSnoozed ? TextDecoration.lineThrough : null,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
