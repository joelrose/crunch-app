import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/checkout/models/check_out_item_amount.dart';
import 'package:pickup/screens/checkout/models/check_out_vm.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class CheckOutItemsWidget extends StatelessWidget {
  const CheckOutItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CheckoutItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    final CheckOutVM vm = CheckOutVM(checkoutItems);
    final List<CheckoutItemAmount> checkoutSummaryList = vm.checkoutSummaryList;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: checkoutSummaryList.length,
            shrinkWrap: true,
            itemBuilder: (context, itemIndex) {
              final checkoutSummaryItem = checkoutSummaryList[itemIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: _buildItem(checkoutSummaryItem, context),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(CheckoutItemAmount item, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${item.amount}x ${item.checkoutItem.title.english}',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          Utilities.currencyFormat(
            item.totalPrice,
          ),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: AlpacaColor.darkNavyColor),
        ),
      ],
    );
  }
}
