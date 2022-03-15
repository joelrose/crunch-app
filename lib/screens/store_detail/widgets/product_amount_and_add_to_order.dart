import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';

class ProductAmountAndAddToOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreDetailCubit, StoreDetailState>(
      builder: (context, state) {
        return Column(
          children: [
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  _buildSelect(context),
                  _buildButton(context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 30,
      ),
      child: ActionButton(
        onPressed: () {
          context.read<StoreDetailCubit>().addToOrderOnClick();
          Navigator.pop(context);
        },
        buttonText: 'Add to order',
      ),
    );
  }

  Widget _buildSelect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: AlpacaColor.greyColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AlpacaSelect(
              amount: context
                  .read<StoreDetailCubit>()
                  .amountOfProductsToAddToBasket
                  .toString(),
              onDecrease: () =>
                  context.read<StoreDetailCubit>().decreaseItemAmount(),
              onIncrease: () =>
                  context.read<StoreDetailCubit>().increaseItemAmount(),
              textBoxHorizontalPadding: 12,
              textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    color: AlpacaColor.darkNavyColor,
                  ),
            ),
          ),
          Text(
            Utilities.currencyFormat(
              context.read<StoreDetailCubit>().totalPrice,
            ),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AlpacaColor.primary100,
                ),
          ),
        ],
      ),
    );
  }
}
