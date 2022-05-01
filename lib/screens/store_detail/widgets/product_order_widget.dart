import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';
import 'package:pickup/shared/utilities.dart';
import 'package:pickup/l10n/l10n.dart';

class ProductOrderWidget extends StatelessWidget {
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
        onPressed: () => context.read<StoreDetailCubit>().addToOrderOnClick(),
        buttonText: context.l10n.addToOrder,
      ),
    );
  }

  Widget _buildSelect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAlpacaSelect(context),
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

  Widget _buildAlpacaSelect(BuildContext context) {
    final cubit = context.read<StoreDetailCubit>();

    return Container(
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
        amount: cubit.amountOfProductsToAddToBasket.toString(),
        onDecrease: () => cubit.decreaseItemAmount(),
        onIncrease: () => cubit.increaseItemAmount(),
        textBoxHorizontalPadding: 12,
        textStyle: Theme.of(context).textTheme.headline2!.copyWith(
              color: AlpacaColor.darkNavyColor,
            ),
      ),
    );
  }
}
