import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/checkout/models/check_out_item_amount.dart';
import 'package:pickup/screens/checkout/models/check_out_vm.dart';
import 'package:pickup/screens/store_detail/widgets/product_amount_and_add_to_order.dart';
import 'package:pickup/shared/utilities.dart';

class CheckOutItemsWidget extends StatelessWidget {
  const CheckOutItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CreateOrderItemDto> checkoutItems;

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.amount}x ${item.checkoutItem.name}',
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
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.checkoutItem.items?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, itemIndex) {
            final option = item.checkoutItem.items![itemIndex];
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 3,
                bottom: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(option.name!),
                  AlpacaSelect(
                      onDecrease: () {}, onIncrease: () {}, amount: '1'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
