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
    this.optionalParentPlu = '',
  }) : super(key: key);

  final String name;
  final int index;
  final DeliverectProductModelDto optionCategory;
  final String optionalParentPlu;
  final int itemOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRestrictionText(context),
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
              optionCategory: optionCategory,
              itemCategoryIndex: index,
              itemOptionIndex: itemOptionIndex,
              optionalParentPlu: optionalParentPlu,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestrictionText(BuildContext context) {
    final min = optionCategory.min!;
    final max = optionCategory.max!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline3,
        ),
        if (min != 0 && max != 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '(min: $min, max: $max)',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
      ],
    );
  }
}
