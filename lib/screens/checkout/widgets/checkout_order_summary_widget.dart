import 'package:alpaca/global.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';

class CheckoutOrderSummaryWidget extends StatelessWidget {
  const CheckoutOrderSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AlpacaColor.lightGreyColor90),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order summary',
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 18, color: AlpacaColor.darkNavyColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                        color: AlpacaColor.darkGreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    '12.99€',
                    style: TextStyle(
                        color: AlpacaColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Discount',
                    style: TextStyle(
                        color: AlpacaColor.darkGreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    '-2.99€',
                    style: TextStyle(
                        color: AlpacaColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
