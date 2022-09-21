import 'package:alpaca/alpaca.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/store_detail.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryState =
        context.select((ProductOptionCubit cubit) => cubit.state);

    final categoryOptions = categoryState.optionCategory.products;

    return ListView.separated(
      itemCount: categoryOptions!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0,
        );
      },
      itemBuilder: (context, optionIndex) {
        return BlocProvider(
          create: (context) => ProductDetailCubit(
            storeDetailCubit: context.read<StoreDetailCubit>(),
            category: categoryState.optionCategory,
            categoryIndex: categoryState.index,
            optionIndex: optionIndex,
          ),
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state.status.isReloading) {
                /*final showChildren = state.item!.childProducts != null &&
                      state.item!.childProducts!.isNotEmpty &&
                      state.isSelected;*/

                final showSelector =
                    (categoryState.optionCategory.multiMax ?? 1) > 1 &&
                        state.isSelected;
                return Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: !state.isSnoozed
                          ? () => context.read<ProductDetailCubit>().onTapped()
                          : null,
                      child: const _Content(),
                    ),
                    if (showSelector) ...[
                      const _Select(),
                    ],
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((ProductDetailCubit c) => c.state);

    return Row(
      children: [
        if (state.isRadio) ...[
          Radio(
            value: state.item!.plu!,
            toggleable: !state.isSnoozed,
            groupValue: state.isSelected ? state.item!.plu! : '',
            activeColor: AlpacaColor.primary100,
            onChanged: state.isSnoozed
                ? null
                : (_) => context.read<ProductDetailCubit>().onTappedRadio(),
          ),
        ] else ...[
          Checkbox(
            value: state.isSelected,
            activeColor: AlpacaColor.primary100,
            onChanged: state.isSnoozed
                ? null
                : (_) => context.read<ProductDetailCubit>().onTappedCheckBox(),
          ),
        ],
        OptionPrice(
          name: state.item!.name!,
          price: state.item!.price!,
          isSnoozed: state.isSnoozed,
        ),
      ],
    );
  }
}

class _Select extends StatelessWidget {
  const _Select({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        final state = context.read<ProductDetailCubit>().state;

        final amount = state.orderDto
            .firstWhereOrNull(
              (element) => element.plu == state.item!.plu,
            )
            ?.quantity;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AlpacaSelect(
                onDecrease: () =>
                    context.read<ProductDetailCubit>().onDecrease(),
                onIncrease: () =>
                    context.read<ProductDetailCubit>().onIncrease(),
                amount: amount.toString(),
                textBoxHorizontalPadding: 12,
                textStyle: const TextStyle(),
              ),
            ],
          ),
        );
      },
    );
  }
}
