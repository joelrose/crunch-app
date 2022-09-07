import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/price_calculation.dart';
import 'package:pickup/shared/utilities.dart';

class ItemsOverview extends StatelessWidget {
  const ItemsOverview({Key? key, this.isEditable = true}) : super(key: key);

  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBasketBloc, CheckoutBasketState>(
      listener: (context, state) {
        if (state.checkoutItems.isEmpty) {
          Navigator.of(context).pop();
        }
      },
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
                  return _Item(checkoutSummaryItem, itemIndex, isEditable);
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
  // ignore: avoid_positional_boolean_parameters
  const _Item(this.item, this.itemIndex, this.isEditable, {Key? key})
      : super(key: key);

  final CreateOrderItemDto item;
  final int itemIndex;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    if (isEditable) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            context.l10n.deleteItem,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AlpacaColor.white100Color,
                ),
          ),
        ),
        onDismissed: (direction) {
          context
              .read<CheckoutBasketBloc>()
              .add(CheckoutBasketItemDeleted(itemIndex: itemIndex));
        },
        direction: DismissDirection.endToStart,
        child: _Content(context),
      );
    } else {
      return _Content(context);
    }
  }

  Widget _Content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                if (item.items != null && item.items!.isNotEmpty) ...[
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
