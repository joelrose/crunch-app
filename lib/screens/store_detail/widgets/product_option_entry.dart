import 'package:alpaca/alpaca.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_list_view.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_price.dart';

class ProductOptionEntry extends StatelessWidget {
  const ProductOptionEntry({
    Key? key,
    required this.optionCategory,
    required this.itemCategoryIndex,
    this.itemOptionIndex = -1,
    this.optionalParentPlu = '',
  }) : super(key: key);

  final DeliverectProductModelDto optionCategory;
  final String optionalParentPlu;
  final int itemCategoryIndex;
  final int itemOptionIndex;

  @override
  Widget build(BuildContext context) {
    final categoryOptions = optionCategory.childProducts!;

    final cubit = context.read<StoreDetailCubit>();

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

        List<CreateOrderItemDto> orderDto;

        final _orderDto = cubit.orderDto;

        orderDto = _orderDto[itemCategoryIndex].items!;

        if (itemOptionIndex != -1) {
          orderDto = orderDto
              .firstWhere((element) => element.plu == optionalParentPlu)
              .items!;
        }

        final isRadio = optionCategory.min == 1 && optionCategory.max == 1;
        final isSnoozed = value.snoozed!;
        final isSelected = orderDto.indexWhere(
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
                          optionCategory,
                          cubit,
                          itemCategoryIndex,
                          optionChoiceIndex,
                          orderDto,
                        )
                      : onTappedCheckBox(
                          optionCategory,
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
                                optionCategory,
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
                                optionCategory,
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
            if ((optionCategory.multiMax ?? 1) > 1 && isSelected) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AlpacaSelect(
                      onDecrease: () {
                        final index = orderDto.firstWhereOrNull(
                          (element) => element.plu == value.plu!,
                        );

                        if (index != null && index.quantity != 1) {
                          index.quantity = index.quantity! - 1;
                        } else {
                          orderDto.remove(index);
                        }

                        cubit.changeItemPrice();
                      },
                      onIncrease: () {
                        final index = orderDto.firstWhereOrNull(
                          (element) => element.plu == value.plu!,
                        );

                        if (index != null &&
                            index.quantity! < optionCategory.multiMax!) {
                          index.quantity = index.quantity! + 1;
                        }

                        cubit.changeItemPrice();
                      },
                      amount: orderDto
                              .firstWhereOrNull(
                                (element) => element.plu == value.plu!,
                              )
                              ?.quantity
                              .toString() ??
                          '1',
                      textBoxHorizontalPadding: 12,
                      textStyle: const TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
            if (value.childProducts != null &&
                value.childProducts!.isNotEmpty &&
                isSelected) ...[
              for (final childItem in value.childProducts!)
                ProductOptionListView(
                  name: childItem.childProduct!.name!,
                  index: itemCategoryIndex,
                  optionCategory: childItem.childProduct!,
                  itemOptionIndex: optionChoiceIndex,
                  optionalParentPlu: value.plu!,
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
    List<CreateOrderItemDto> orderDto,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      orderDto.clear();

      orderDto.add(
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
    List<CreateOrderItemDto> orderDto,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      final index = orderDto.indexWhere(
        (element) => element.plu == value.plu!,
      );

      if (index != -1) {
        orderDto.removeAt(index);
        cubit.changeItemPrice();
        return;
      }

      orderDto.add(
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
