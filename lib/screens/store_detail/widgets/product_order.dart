import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/store_detail/cubits/cubits.dart';
import 'package:pickup/shared/utilities.dart';

class ProductOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: check if it still reloads
    return Column(
      children: [
        const Divider(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: const [
              _SelectContainer(),
              _SubmitButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 30,
      ),
      child: ActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          context.read<StoreDetailCubit>().addProductToBasket();
        },
        buttonText: context.l10n.addToOrder,
      ),
    );
  }
}

class _SelectContainer extends StatelessWidget {
  const _SelectContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPrice =
        context.select((StoreDetailCubit cubit) => cubit.state.price);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _SelectContent(),
          Text(
            Utilities.currencyFormat(
              totalPrice,
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

class _SelectContent extends StatelessWidget {
  const _SelectContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basketAmount =
        context.select((StoreDetailCubit cubit) => cubit.state.basketAmount);

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
        amount: basketAmount.toString(),
        onDecrease: () => context.read<StoreDetailCubit>().decreaseItemAmount(),
        onIncrease: () => context.read<StoreDetailCubit>().increaseItemAmount(),
        textBoxHorizontalPadding: 12,
        textStyle: Theme.of(context).textTheme.headline2!.copyWith(
              color: AlpacaColor.darkNavyColor,
            ),
      ),
    );
  }
}
