import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/widgets/product_amount_and_add_to_order.dart';
import 'package:pickup/shared/extensions.dart';
import 'package:pickup/shared/utilities.dart';

class CheckOutItemsWidget extends StatefulWidget {
  const CheckOutItemsWidget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<CreateOrderItemDto> checkoutItems;

  @override
  State<CheckOutItemsWidget> createState() => _CheckOutItemsWidgetState();
}

class _CheckOutItemsWidgetState extends State<CheckOutItemsWidget> {
  late List<bool> showSelect;

  @override
  void initState() {
    showSelect = List.generate(widget.checkoutItems.length, (index) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.checkoutItems.length,
            shrinkWrap: true,
            itemBuilder: (context, itemIndex) {
              final checkoutSummaryItem = widget.checkoutItems[itemIndex];
              return TextButton(
                onPressed: () {
                  setState(() {
                    showSelect[itemIndex] = !showSelect[itemIndex];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 18,
                  ),
                  child: _buildItem(checkoutSummaryItem, showSelect[itemIndex]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(CreateOrderItemDto item, bool showSelect) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.quantity}x ${item.name}',
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
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item.items?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  final option = item.items![itemIndex];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option.name!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (showSelect)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AlpacaSelect(
                  onDecrease: () {},
                  onIncrease: () {},
                  amount: '1',
                  textBoxHorizontalPadding: 10,
                  textBoxWidth: 5,
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
}
