import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_entry.dart';

class ProductOptionListView extends StatelessWidget {
  const ProductOptionListView({
    Key? key,
    required this.name,
    required this.index,
    required this.optionCategory,
    this.itemOptionIndex = -1,
  }) : super(key: key);

  final String name;
  final int index;
  final ProductRelationModelDto optionCategory;
  final int itemOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline3,
              ),
              if (optionCategory.childProduct!.min! != 0 &&
                  optionCategory.childProduct!.max! != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '(min: ${optionCategory.childProduct!.min!}, '
                    'max: ${optionCategory.childProduct!.max!})',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: AlpacaColor.greyColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ProductOptionEntry(
              item: optionCategory.childProduct!,
              itemCategoryIndex: index,
              itemOptionIndex: itemOptionIndex,
            ),
          ),
        ],
      ),
    );
  }
}
