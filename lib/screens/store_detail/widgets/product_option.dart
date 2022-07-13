import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubits/cubits.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_list_view.dart';

class ProductOption extends StatelessWidget {
  const ProductOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: check if bloc builder is neccessary here
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final optionCategories = context.select(
          (StoreDetailCubit cubit) => cubit.state.item.childProducts,
        )!;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: optionCategories.length,
          itemBuilder: (context, optionCategoryIndex) {
            final item = optionCategories[optionCategoryIndex].childProduct!;

            return ProductOptionListView(
              name: item.name!,
              index: optionCategoryIndex,
              optionCategory: item,
            );
          },
        );
      },
    );
  }
}
