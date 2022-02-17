import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';

class ProductRadioCheckbox extends StatefulWidget {
  const ProductRadioCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  _ProductRadioCheckboxState createState() => _ProductRadioCheckboxState();
}

class _ProductRadioCheckboxState extends State<ProductRadioCheckbox> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final cubit = context.read<StoreDetailCubit>();

        final itemPrice = cubit.data.item.price;
        
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              context.read<StoreDetailCubit>().data.item.itemOptions?.length ??
                  0,
          itemBuilder: (context, itemCategoryIndex) {
            final item = context
                .read<StoreDetailCubit>()
                .data
                .item
                .itemOptions![itemCategoryIndex];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.english,
                    style: Theme.of(context).textTheme.headline3,
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
                            cubit.itemTitleAndOptionsList[itemCategoryIndex]
                                .option.id = item.options[optionChoiceIndex].id;

                            cubit
                                .itemTitleAndOptionsList[itemCategoryIndex]
                                .option
                                .title = item.options[optionChoiceIndex].title;

                            cubit
                                .itemTitleAndOptionsList[itemCategoryIndex]
                                .option
                                .price = item.options[optionChoiceIndex].price;

                            cubit.changeItemPrice(
                              cubit.data.item.price.toDouble(),
                              item.options[optionChoiceIndex].price.toDouble(),
                            );
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: item.options[optionChoiceIndex].id,
                                groupValue: context
                                    .read<StoreDetailCubit>()
                                    .itemTitleAndOptionsList[itemCategoryIndex]
                                    .option
                                    .id,
                                onChanged: (value) {
                                  cubit
                                      .itemTitleAndOptionsList[
                                          itemCategoryIndex]
                                      .option
                                      .id = value.toString();

                                  cubit.changeItemPrice(
                                    itemPrice.toDouble(),
                                    item.options[optionChoiceIndex].price
                                        .toDouble(),
                                  );
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
                                            .headline4!
                                            .copyWith(
                                              color: AlpacaColor.darkNavyColor,
                                            ),
                                      ),
                                      if (item.options[optionChoiceIndex]
                                              .price !=
                                          0)
                                        Text(
                                          '+${item.options[optionChoiceIndex].price.toString()} €',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                color: AlpacaColor.primary100,
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
