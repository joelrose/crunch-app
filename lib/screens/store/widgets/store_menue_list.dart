import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/store_detail/view/store_detail_page.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class StoreMenueList extends StatelessWidget {
  StoreMenueList({
    Key? key,
    required this.menueCategories,
    required this.onCheckoutChange,
    required this.restaurantImage,
  }) : super(key: key);

  final List<RestaurantMenueCategoryModel> menueCategories;
  final void Function(List<CheckoutItemModel>) onCheckoutChange;
  final String restaurantImage;

  late List<CheckoutItemModel> checkoutItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        ListView.builder(
          itemCount: menueCategories.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, j) {
            final category = menueCategories[j];
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                  title: Text(
                    category.title.english,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const AlpacaDivider(),
                ListView.separated(
                  itemCount: category.menueItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final item = category.menueItems[i];
                    return _buildCard(item, context);
                  },
                  separatorBuilder: (context, index) {
                    return const AlpacaDivider();
                  },
                ),
                const AlpacaDivider(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(RestaurantMenueItemModel item, BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(
        StoreDetailPage.route,
        arguments: ProductDetailsData(
          item: item,
          restaurantImage: restaurantImage,
          checkoutItems: checkoutItems,
          onCheckoutChange: onCheckoutChange,
        ),
      ),
      style: TextButton.styleFrom(
        primary: AlpacaColor.primary100,
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 34, 18),
              child: Wrap(
                runSpacing: 10,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title.english,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      if ((checkoutItems.indexWhere(
                            (checkouItem) => checkouItem.id == item.id,
                          )) !=
                          -1)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '${checkoutItems.where(
                                  (listItem) => item.id == listItem.id,
                                ).length}x',
                            overflow: TextOverflow.clip,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: AlpacaColor.primary80,
                                    ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Grilled sandwich with fillet, cheese, tomatoes and salad',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    Utilities.currencyFormat(item.price),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: AlpacaColor.primary80),
                  ),
                ],
              ),
            ),
          ),
          Image.network(
            'https://picsum.photos/250?image=18',
            fit: BoxFit.fitHeight,
            width: 114,
            height: 134,
          ),
        ],
      ),
    );
  }
}
