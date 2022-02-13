import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class CheckoutOrderSummaryItem extends StatelessWidget {
  const CheckoutOrderSummaryItem({
    Key? key,
    required this.labelText,
    required this.price,
  }) : super(key: key);

  final String labelText;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              color: AlpacaColor.darkGreyColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: AlpacaColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutOrderSummaryWidget extends StatelessWidget {
  const CheckoutOrderSummaryWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CheckoutItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AlpacaColor.lightGreyColor90),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order summary',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
              ),
            ),
            CheckoutOrderSummaryItem(
              labelText: 'Subtotal',
              price: Utilities.currencyFormat(
                checkoutItems.getTotalPrice(),
              ),
            ),
            CheckoutOrderSummaryItem(
              labelText: 'Discount',
              price: Utilities.currencyFormat(
                0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
