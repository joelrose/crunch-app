import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/utilities.dart';

class CheckOutItemsWidget extends StatefulWidget {
  CheckOutItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  List<CreateOrderItemDto> checkoutItems;

  @override
  State<CheckOutItemsWidget> createState() => _CheckOutItemsWidgetState();
}

class _CheckOutItemsWidgetState extends State<CheckOutItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.checkoutItems.length,
            shrinkWrap: true,
            itemBuilder: (context, itemIndex) {
              final checkoutSummaryItem = widget.checkoutItems[itemIndex];
              return TextButton(
                style: TextButton.styleFrom(
                  primary: AlpacaColor.primary100,
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 18,
                  ),
                  child: _buildItem(context, checkoutSummaryItem, itemIndex),
                ),
              );
            },
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    CreateOrderItemDto item,
    int itemIndex,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name!,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              Utilities.currencyFormat(PriceCalulcation.getPriceOfItem(item)),
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
            _buildItemDescription(item),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AlpacaSelect(
                onDecrease: () {
                  if (item.quantity == 1) {
                    setState(() {
                      widget.checkoutItems.removeAt(itemIndex);
                    });
                  } else {
                    setState(() {
                      widget.checkoutItems[itemIndex].quantity =
                          widget.checkoutItems[itemIndex].quantity! - 1;
                    });
                  }
                },
                onIncrease: () {
                  setState(() {
                    widget.checkoutItems[itemIndex].quantity =
                        widget.checkoutItems[itemIndex].quantity! + 1;
                  });
                },
                amount: item.quantity!.toString(),
                textBoxHorizontalPadding: 12,
                textStyle: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.darkNavyColor,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getDescription(CreateOrderItemDto item) {
    if (item.items != null) {
      final buffer = StringBuffer();

      for (final item in item.items!) {
        buffer.write('${item.name!}, ');
      }

      return buffer.toString();
    }

    return '';
  }

  Widget _buildItemDescription(CreateOrderItemDto item) {
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
}
