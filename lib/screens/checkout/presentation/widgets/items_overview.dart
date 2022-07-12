import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/price_calculation.dart';
import 'package:pickup/shared/utilities.dart';

class ItemsOverview extends StatelessWidget {
  const ItemsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBasketBloc, CheckoutBasketState>(
      builder: (context, state) {
        return Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.checkoutItems.length,
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  final checkoutSummaryItem = state.checkoutItems[itemIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 18,
                    ),
                    child: _Item(checkoutSummaryItem, itemIndex),
                  );
                },
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.item, this.itemIndex, {Key? key}) : super(key: key);

  final CreateOrderItemDto item;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Text(
          'Delete item',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AlpacaColor.blackColor,
              ),
        ),
      ),
      onDismissed: (direction) {
        context
            .read<CheckoutBasketBloc>()
            .add(CheckoutBasketItemDeleted(itemIndex: itemIndex));
      },
      direction: DismissDirection.endToStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(
              item.quantity!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        Utilities.currencyFormat(
                          PriceCalulcation.getPriceOfItem(item),
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: AlpacaColor.blackColor),
                      ),
                    ],
                  ),
                  if (item.items != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ItemDescription(item),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription(this.item, {Key? key}) : super(key: key);

  final CreateOrderItemDto item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6,
          right: 60,
        ),
        child: Text(
          _getDescription(item),
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  String _getDescription(CreateOrderItemDto item) {
    if (item.items != null) {
      final buffer = StringBuffer();

      for (final item in item.items!) {
        buffer.write('${item.name!}, ');
      }

      final string = buffer.toString();

      return string == ''
          ? string
          : string.substring(
              0,
              string.length - 2,
            );
    }

    return '';
  }
}
