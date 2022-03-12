import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:sanity/sanity.dart';

class ProductRadioCheckbox extends StatelessWidget {
  const ProductRadioCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final optionCategories =
            (state as StoreDetailReload).data.item.childProducts;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: optionCategories?.length ?? 0,
          itemBuilder: (context, optionCategoryIndex) {
            final item = optionCategories![optionCategoryIndex];

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
          Text(
            name,
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

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              onTapped(item, cubit, itemCategoryIndex, optionChoiceIndex),
          child: Row(
            children: [
              Radio(
                value: value.plu!,
                groupValue: cubit.categoryList[itemCategoryIndex].option.plu,
                activeColor: AlpacaColor.primary100,
                onChanged: (String? value) =>
                    onTapped(item, cubit, itemCategoryIndex, optionChoiceIndex),
              ),
              _buildPriceText(context, value.name!, value.price)
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriceText(BuildContext context, String name, int? price) {
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
                  ),
            ),
            if (price != 0)
              Text(
                '+${Utilities.currencyFormat(price!)}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AlpacaColor.primary100,
                    ),
              ),
          ],
        ),
      ),
    );
  }

  void onTapped(
    DeliverectProductModelDto item,
    StoreDetailCubit cubit,
    int itemCategoryIndex,
    int optionChoiceIndex,
  ) {
    {
      final value =
          item.childProducts!.elementAt(optionChoiceIndex).childProduct!;

      cubit.categoryList[itemCategoryIndex].option =
          CheckoutOptionForItemOptionsModel(
        name: value.name!,
        price: value.price!,
        plu: value.plu!,
      );

      cubit.categoryList[itemCategoryIndex].option.plu = value.plu!;

      cubit.changeItemPrice(
        cubit.data.item.price!,
        value.price!,
      );
    }
  }
}
