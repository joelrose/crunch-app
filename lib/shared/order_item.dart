import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/app.dart';
import 'package:pickup/shared/shared.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    Key? key,
    required this.item,
    required this.isEditable,
    this.itemIndex = 0,
  }) : super(key: key);

  final OrderItem item;
  final int itemIndex;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    if (isEditable) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: AlpacaColor.redColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            context.l10n.deleteItem,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AlpacaColor.white100Color,
                ),
          ),
        ),
        onDismissed: (direction) => _deleteItem(context),
        direction: DismissDirection.endToStart,
        child: _content(context),
      );
    } else {
      return _content(context);
    }
  }

  void _deleteItem(BuildContext context) {
    context
        .read<CheckoutBasketBloc>()
        .add(CheckoutBasketItemDeleted(itemIndex: itemIndex));
  }

  Widget _content(BuildContext context) {
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
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    if (item.subItems != null && item.subItems!.isNotEmpty) ...[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: _ItemDescription(item),
                      ),
                    ]
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Utilities.currencyFormat(
                        PriceCalulcation.getPriceOfItem(item),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AlpacaColor.blackColor),
                    ),
                    if (isEditable) ...[
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () => _deleteItem(context),
                        child: SvgPicture.asset(
                          'assets/icons/trash.svg',
                          width: 18,
                          height: 18,
                          color: AlpacaColor.lightBlackColor,
                        ),
                      ),
                    ],
                  ],
                ),
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

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        right: 60,
      ),
      child: Text(
        _getDescription(item),
        style: Theme.of(context).textTheme.headline5,
        overflow: TextOverflow.ellipsis,
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
