import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/shared.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.items}) : super(key: key);

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, itemIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: _Item(item: items[itemIndex]),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.item}) : super(key: key);

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name!,
              style: Theme.of(context).textTheme.headline4,
            ),
            if (item.items != null)
              Text(
                Utilities.currencyFormat(_getPriceOfItem(item)),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AlpacaColor.darkNavyColor),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ItemDescription(item),
          ],
        ),
      ],
    );
  }

  // TODO: temp fix
  int _getPriceOfItem(OrderItemModel item) {
    _assertItem(item);

    return item.quantity! * (_getPriceOfItems(item.items) + (item.price!));
  }

  int _getPriceOfItems(List<OrderItemModel>? items) {
    if (items == null || items.isEmpty) {
      return 0;
    }

    var optionPrice = 0;
    for (final item in items) {
      _assertItem(item);

      optionPrice +=
          item.quantity! * (_getPriceOfItems(item.items) + item.price!);
    }

    return optionPrice;
  }

  void _assertItem(OrderItemModel item) {
    assert(item.quantity != null && item.quantity != 0);
    assert(item.price != null);
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription(this.item, {Key? key}) : super(key: key);

  final OrderItemModel item;

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

  String _getDescription(OrderItemModel item) {
    if (item.items != null) {
      final buffer = StringBuffer();

      for (final item in item.items!) {
        buffer.write('${item.name!}, ');
      }

      return buffer.toString();
    }

    return '';
  }
}
