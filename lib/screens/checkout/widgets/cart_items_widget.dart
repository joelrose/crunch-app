import 'package:alpaca/global.dart';
import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/material.dart';
import 'package:alpaca/screens/checkout/widgets/checkout_header_row_widget.dart';

class cart_items_widget extends StatelessWidget {
  const cart_items_widget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<RestaurantMenueItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkout_header_row_widget(
          header: 'Cart items',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: checkoutItems.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final checkoutItem = checkoutItems[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1x ${checkoutItem.title.english}',
                      style: const TextStyle(
                          color: AlpacaColor.darkGreyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    Text(
                      '${checkoutItem.price}€',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
