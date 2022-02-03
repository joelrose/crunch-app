import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:sanity/sanity.dart';

class ProductRadioCheckbox extends StatefulWidget {
  const ProductRadioCheckbox({
    Key? key,
    required this.itemCategories,
    required this.itemPrice,
    required this.changeItemPrice,
    required this.itemTitleAndOptionsList,
  }) : super(key: key);
  final List<RestaurantMenueItemOptions>? itemCategories;
  final double itemPrice;
  final Function changeItemPrice;
  final List<CheckoutItemOptionsModel> itemTitleAndOptionsList;

  @override
  _ProductRadioCheckboxState createState() => _ProductRadioCheckboxState();
}

class _ProductRadioCheckboxState extends State<ProductRadioCheckbox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.itemCategories?.length ?? 0,
      itemBuilder: (context, itemCategoryIndex) {
        final item = widget.itemCategories![itemCategoryIndex];

        return StatefulBuilder(
          builder: (
            BuildContext context,
            StateSetter setState,
          ) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.english,
                    style: Theme.of(context).textTheme.headline2,
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
                    child: ListView.separated(
                      itemCount: item.options.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, optionChoiceIndex) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            widget.changeItemPrice(
                              widget.itemPrice,
                              item.options[optionChoiceIndex].price.toDouble(),
                            );
                            setState(() {
                              widget
                                  .itemTitleAndOptionsList[itemCategoryIndex]
                                  .option
                                  .id = item.options[optionChoiceIndex].id;

                              widget.itemTitleAndOptionsList[itemCategoryIndex]
                                      .option.title =
                                  item.options[optionChoiceIndex].title;

                              widget.itemTitleAndOptionsList[itemCategoryIndex]
                                      .option.price =
                                  item.options[optionChoiceIndex].price;
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: item.options[optionChoiceIndex].id,
                                groupValue: widget
                                    .itemTitleAndOptionsList[itemCategoryIndex]
                                    .option
                                    .id,
                                onChanged: (value) {
                                  widget.changeItemPrice(
                                    widget.itemPrice,
                                    item.options[optionChoiceIndex].price
                                        .toDouble(),
                                  );
                                  setState(() {
                                    widget
                                        .itemTitleAndOptionsList[
                                            itemCategoryIndex]
                                        .option
                                        .id = value.toString();
                                  });
                                },
                                activeColor: AlpacaColor.primary100,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 17),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.options[optionChoiceIndex].title
                                            .english,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                color:
                                                    AlpacaColor.darkNavyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                      ),
                                      if (item.options[optionChoiceIndex]
                                              .price !=
                                          0)
                                        Text(
                                          '+ ${item.options[optionChoiceIndex].price.toString()}€',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .merge(
                                                const TextStyle(
                                                  color: AlpacaColor.primary100,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
