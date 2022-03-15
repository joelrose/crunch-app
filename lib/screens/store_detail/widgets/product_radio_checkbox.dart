import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:collection/collection.dart';

class ProductRadioCheckbox extends StatelessWidget {
  const ProductRadioCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final optionCategories =
            (state as StoreDetailReload).data.item.childProducts;

        optionCategories!.sort(
          (a, b) =>
              a.childProduct!.sortOrder!.compareTo(b.childProduct!.sortOrder!),
        );

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: optionCategories.length,
          itemBuilder: (context, optionCategoryIndex) {
            final item = optionCategories[optionCategoryIndex];

            return _buildListView(
              context,
              name: item.childProduct!.name!,
              index: optionCategoryIndex,
              optionCategory: item,
            );
          },
        );
      },
    );
  }

  Widget _buildListView(
    BuildContext context, {
    required String name,
    required int index,
    required ProductRelationModelDto optionCategory,
  }) {
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
                    '(min: ${optionCategory.childProduct!.min!}, max: ${optionCategory.childProduct!.max!})',
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
            child: _buildOptions(context, optionCategory.childProduct!, index),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(
    BuildContext context,
    DeliverectProductModelDto item,
    int itemCategoryIndex,
  ) {
    final cubit = context.read<StoreDetailCubit>();

    final categoryOptions = item.childProducts!;

    categoryOptions.sort(
      (a, b) =>
          a.childProduct!.sortOrder!.compareTo(b.childProduct!.sortOrder!),
    );

    return ListView.separated(
      itemCount: categoryOptions.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0,
        );
      },
      itemBuilder: (context, optionChoiceIndex) {
        final value =
            categoryOptions.elementAt(optionChoiceIndex).childProduct!;

        final isRadio = item.min == 1 && item.max == 1;
        final isSnoozed = value.snoozed!;
        final isSelected = cubit.orderDto[itemCategoryIndex].items!.indexWhere(
              (element) => element.plu == value.plu!,
            ) !=
            -1;

        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: !isSnoozed
                  ? () => isRadio
                      ? onTappedRadio(
                          item,
                          cubit,
                          itemCategoryIndex,
                          optionChoiceIndex,
                        )
                      : onTappedCheckBox(
                          item,
                          cubit,
                          itemCategoryIndex,
                          optionChoiceIndex,
                        )
                  : null,
              child: Row(
                children: [
                  if (isRadio) ...[
                    Radio(
                      value: value.plu!,
                      toggleable: !isSnoozed,
                      groupValue: isSelected ? value.plu! : '',
                      activeColor: AlpacaColor.primary100,
                      onChanged: isSnoozed
                          ? null
                          : (String? value) => onTappedRadio(
                                item,
                                cubit,
                                itemCategoryIndex,
                                optionChoiceIndex,
                              ),
                    ),
                  ] else ...[
                    Checkbox(
                      value: isSelected,
                      activeColor: AlpacaColor.primary100,
                      onChanged: isSnoozed
                          ? null
                          : (value) => onTappedCheckBox(
                                item,
                                cubit,
                                itemCategoryIndex,
                                optionChoiceIndex,
                              ),
                    ),
                  ],
                  _buildPriceText(context, value.name!, value.price, isSnoozed),
                ],
              ),
            ),
            if ((item.multiMax ?? 1) > 1 && isSelected) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AlpacaSelect(
                        onDecrease: () {
                          final index = cubit.orderDto[itemCategoryIndex].items!
                              .firstWhereOrNull(
                            (element) => element.plu == value.plu!,
                          );

                          if (index != null && index.quantity != 1) {
                            index.quantity = index.quantity! - 1;
                          } else {
                            cubit.orderDto[itemCategoryIndex].items!
                                .remove(index);
                          }

                          cubit.changeItemPrice();
                        },
                        onIncrease: () {
                          final index = cubit.orderDto[itemCategoryIndex].items!
                              .firstWhereOrNull(
                            (element) => element.plu == value.plu!,
                          );

                          if (index != null &&
                              index.quantity! < item.multiMax!) {
                            index.quantity = index.quantity! + 1;
                          }

                          cubit.changeItemPrice();
                        },
                        amount: cubit.orderDto[itemCategoryIndex].items!
                                .firstWhereOrNull(
                                  (element) => element.plu == value.plu!,
                                )
                                ?.quantity
                                .toString() ??
                            '1',
                        textBoxHorizontalPadding: 12,
                        textStyle: TextStyle()),
                  ],
                ),
              ),
            ],
            if (value.childProducts != null &&
                value.childProducts!.isNotEmpty &&
                cubit.orderDto[itemCategoryIndex].items!.indexWhere(
                      (element) => element.plu == value.plu!,
                    ) !=
                    -1) ...[
              for (final item in value.childProducts!)
                _buildListView(
                  context,
                  name: item.childProduct!.name!,
                  index: itemCategoryIndex,
                  optionCategory: item,
                ),
            ]
          ],
        );
      },
    );
  }

  Widget _buildPriceText(
    BuildContext context,
    String name,
    int? price,
    bool isSnoozed,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AlpacaColor.darkNavyColor,
                    decoration: isSnoozed ? TextDecoration.lineThrough : null,
                  ),
            ),
            if (price != 0)
              Text(
                '+${Utilities.currencyFormat(price!)}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.primary100,
                      decoration: isSnoozed ? TextDecoration.lineThrough : null,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  void onTappedRadio(
    DeliverectProductModelDto item,
    StoreDetailCubit cubit,
    int itemCategoryIndex,
    int optionChoiceIndex,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      cubit.orderDto[itemCategoryIndex].items!.clear();

      cubit.orderDto[itemCategoryIndex].items!.add(
        CreateOrderItemDto(
          name: value.name,
          price: value.price,
          plu: value.plu,
          quantity: 1,
        ),
      );

      cubit.changeItemPrice();
    }
  }

  void onTappedCheckBox(
    DeliverectProductModelDto item,
    StoreDetailCubit cubit,
    int itemCategoryIndex,
    int optionChoiceIndex,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      final index = cubit.orderDto[itemCategoryIndex].items!.indexWhere(
        (element) => element.plu == value.plu!,
      );

      if (index != -1) {
        cubit.orderDto[itemCategoryIndex].items!.removeAt(index);
        cubit.changeItemPrice();
        return;
      }

      cubit.orderDto[itemCategoryIndex].items!.add(
        CreateOrderItemDto(
          name: value.name,
          price: value.price,
          plu: value.plu,
          quantity: 1,
        ),
      );

      cubit.changeItemPrice();
    }
  }
}
