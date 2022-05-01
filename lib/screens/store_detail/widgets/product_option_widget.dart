import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/screens/store_detail/widgets/product_option_list_view.dart';

class ProductOptionWidget extends StatelessWidget {
  const ProductOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final optionCategories = context.select(
            (StoreDetailCubit cubit) => cubit.state.item.childProducts)!;

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
