import 'package:alpaca/sanity/model.dart';
import 'package:flutter/material.dart';

class cart_items_widget extends StatelessWidget {
  const cart_items_widget({Key? key, required this.checkoutItems})
      : super(key: key);

  final List<RestaurantMenueItemModel> checkoutItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        itemCount: checkoutItems.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          final checkoutItem = checkoutItems[i];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1x ${checkoutItem.title.english}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${checkoutItem.price}€',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          );
        },
      ),
    );
  }
}
