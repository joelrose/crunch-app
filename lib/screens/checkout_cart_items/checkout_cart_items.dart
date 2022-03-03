import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/checkout/models/check_out_item_amount.dart';
import 'package:pickup/screens/checkout/models/check_out_vm.dart';
import 'package:pickup/screens/checkout/widgets/checkout_main_widget.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class CheckoutCartItemsWidget extends StatelessWidget {
  const CheckoutCartItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CheckoutItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    final CheckOutVM vm = CheckOutVM(checkoutItems);
    final List<CheckoutItemAmount> checkoutSummaryList = vm.checkoutSummaryList;

    return Column(
      children: [
        CheckoutHeaderRowWidget(
          header: 'Cart items',
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: 'Edit',
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: checkoutSummaryList.length,
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  final checkoutSummaryItem = checkoutSummaryList[itemIndex];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${checkoutSummaryItem.amount}x ${checkoutSummaryItem.checkoutItem.title.english}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          Utilities.currencyFormat(
                            checkoutSummaryItem.totalPrice,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: AlpacaColor.darkNavyColor),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const AlpacaDivider(),
      ],
    );
  }
}
