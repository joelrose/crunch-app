import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/shared/shared.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.items}) : super(key: key);

  final List<OrderItem> items;

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

  final OrderItem item;

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
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: AlpacaColor.darkNavyColor),
            ),
            if (item.subItems != null)
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
  int _getPriceOfItem(OrderItem item) {
    _assertItem(item);

    return item.quantity! * (_getPriceOfItems(item.subItems) + (item.price!));
  }

  int _getPriceOfItems(List<OrderItem>? items) {
    if (items == null || items.isEmpty) {
      return 0;
    }

    var optionPrice = 0;
    for (final item in items) {
      _assertItem(item);

      optionPrice +=
          item.quantity! * (_getPriceOfItems(item.subItems) + item.price!);
    }

    return optionPrice;
  }

  void _assertItem(OrderItem item) {
    assert(item.quantity != null && item.quantity != 0);
    assert(item.price != null);
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription(this.item, {Key? key}) : super(key: key);

  final OrderItem item;

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

  String _getDescription(OrderItem item) {
    if (item.subItems != null) {
      final buffer = StringBuffer();

      for (final item in item.subItems!) {
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
