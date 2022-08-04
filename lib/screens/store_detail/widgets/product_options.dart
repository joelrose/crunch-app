import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';

class ProductOptions extends StatelessWidget {
  const ProductOptions({Key? key}) : super(key: key);

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

            return BlocProvider(
              create: (context) => ProductOptionCubit(
                index: optionCategoryIndex,
                optionCategory: item,
              ),
              child: const OptionListView(),
            );
          },
        );
      },
    );
  }
}
