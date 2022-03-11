import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';

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
          itemCount: context
                  .read<StoreDetailCubit>()
                  .data
                  .item
                  .childProducts
                  ?.length ??
              0,
          itemBuilder: (context, itemCategoryIndex) {
            final item = context
                .read<StoreDetailCubit>()
                .data
                .item
                .childProducts![itemCategoryIndex];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.childProduct!.name!,
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
                      itemCount: item.childProduct!.childProducts!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, optionChoiceIndex) {
                        final value = item.childProduct!.childProducts!
                            .elementAt(optionChoiceIndex)
                            .childProduct!;
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            cubit.itemTitleAndOptionsList[itemCategoryIndex]
                                    .option.plu =
                                item.childProduct!.childProducts!
                                    .elementAt(optionChoiceIndex)
                                    .childProduct!
                                    .plu!;

                            cubit.itemTitleAndOptionsList[itemCategoryIndex]
                                    .option.title =
                                item.childProduct!.childProducts!
                                    .elementAt(optionChoiceIndex)
                                    .childProduct!
                                    .name!;

                            cubit.itemTitleAndOptionsList[itemCategoryIndex]
                                    .option.price =
                                item.childProduct!.childProducts!
                                    .elementAt(optionChoiceIndex)
                                    .childProduct!
                                    .price!;

                            cubit.changeItemPrice(
                              cubit.data.item.price!.toDouble(),
                              item.childProduct!.childProducts!
                                  .elementAt(optionChoiceIndex)
                                  .childProduct!
                                  .price!
                                  .toDouble(),
                            );
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: item.childProduct!.childProducts!
                                    .elementAt(optionChoiceIndex)
                                    .childProduct!
                                    .plu!,
                                groupValue: context
                                    .read<StoreDetailCubit>()
                                    .itemTitleAndOptionsList[itemCategoryIndex]
                                    .option
                                    .plu,
                                onChanged: (value) {
                                  cubit
                                      .itemTitleAndOptionsList[
                                          itemCategoryIndex]
                                      .option
                                      .plu = value.toString();

                                  cubit.changeItemPrice(
                                    itemPrice!.toDouble(),
                                    item.childProduct!.childProducts!
                                        .elementAt(optionChoiceIndex)
                                        .childProduct!
                                        .price!
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
                                        item.childProduct!.childProducts!
                                            .elementAt(optionChoiceIndex)
                                            .childProduct!
                                            .name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              color: AlpacaColor.darkNavyColor,
                                            ),
                                      ),
                                      if (value.price != 0)
                                        Text(
                                          '+${Utilities.currencyFormat(value.price!)}',
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
