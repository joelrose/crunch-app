import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_list_view.dart';
import 'package:collection/collection.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_price.dart';

class ProductOptionEntry extends StatelessWidget {
  const ProductOptionEntry({
    Key? key,
    required this.item,
    required this.itemCategoryIndex,
    this.itemOptionIndex = 1,
  }) : super(key: key);

  final DeliverectProductModelDto item;
  final int itemCategoryIndex;
  final int itemOptionIndex;

  @override
  Widget build(BuildContext context) {
    final categoryOptions = item.childProducts!;

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

        final cubit = context.read<StoreDetailCubit>();

        CreateOrderItemDto orderDto;

        if (itemOptionIndex == -1) {
          orderDto = cubit.orderDto[itemCategoryIndex];
        } else {
          if (cubit.orderDto[itemCategoryIndex].items == null) {
            orderDto =
                cubit.orderDto[itemCategoryIndex].items![itemOptionIndex];
          } else if (cubit.orderDto[itemCategoryIndex].items!.length == 1) {
            orderDto =
                cubit.orderDto[itemCategoryIndex].items![itemOptionIndex];
          } else {
            orderDto =
                cubit.orderDto[itemCategoryIndex].items![itemOptionIndex];
            orderDto.items ??= [];
          }
        }

        final isRadio = item.min == 1 && item.max == 1;
        final isSnoozed = value.snoozed!;
        final isSelected = orderDto.items!.indexWhere(
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
                          orderDto,
                        )
                      : onTappedCheckBox(
                          item,
                          cubit,
                          itemCategoryIndex,
                          optionChoiceIndex,
                          orderDto,
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
                                orderDto,
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
                                orderDto,
                              ),
                    ),
                  ],
                  ProductOptionPrice(
                    name: value.name!,
                    price: value.price!,
                    isSnoozed: isSnoozed,
                  ),
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
                          final index = orderDto.items!.firstWhereOrNull(
                            (element) => element.plu == value.plu!,
                          );

                          if (index != null && index.quantity != 1) {
                            index.quantity = index.quantity! - 1;
                          } else {
                            orderDto.items!.remove(index);
                          }

                          cubit.changeItemPrice();
                        },
                        onIncrease: () {
                          final index = orderDto.items!.firstWhereOrNull(
                            (element) => element.plu == value.plu!,
                          );

                          if (index != null &&
                              index.quantity! < item.multiMax!) {
                            index.quantity = index.quantity! + 1;
                          }

                          cubit.changeItemPrice();
                        },
                        amount: orderDto.items!
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
                orderDto.items!.indexWhere(
                      (element) => element.plu == value.plu!,
                    ) !=
                    -1) ...[
              for (final childItem in value.childProducts!)
                ProductOptionListView(
                  name: childItem.childProduct!.name!,
                  index: itemCategoryIndex,
                  optionCategory: childItem.childProduct!,
                  itemOptionIndex: optionChoiceIndex,
                ),
            ]
          ],
        );
      },
    );
  }

  void onTappedRadio(
    DeliverectProductModelDto item,
    StoreDetailCubit cubit,
    int itemCategoryIndex,
    int optionChoiceIndex,
    CreateOrderItemDto orderDto,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      orderDto.items!.clear();

      orderDto.items!.add(
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
    CreateOrderItemDto orderDto,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      final index = orderDto.items!.indexWhere(
        (element) => element.plu == value.plu!,
      );

      if (index != -1) {
        orderDto.items!.removeAt(index);
        cubit.changeItemPrice();
        return;
      }

      orderDto.items!.add(
        CreateOrderItemDto(
          name: value.name,
          price: value.price,
          plu: value.plu,
          quantity: 1,
          items: [],
        ),
      );

      cubit.changeItemPrice();
    }
  }
}
