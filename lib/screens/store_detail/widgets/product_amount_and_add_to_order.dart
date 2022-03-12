import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 20),
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
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: AlpacaColor.greyColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildSelectButton(
                  onTap: () =>
                      context.read<StoreDetailCubit>().decreaseItemAmount(),
                  imagePath: 'assets/icons/minus.svg',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: SizedBox(
                    width: 40,
                    child: Text(
                      context
                          .read<StoreDetailCubit>()
                          .amountOfProductsToAddToBasket
                          .toString(),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: AlpacaColor.darkNavyColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _buildSelectButton(
                  onTap: () =>
                      context.read<StoreDetailCubit>().increaseItemAmount(),
                  imagePath: 'assets/icons/plus.svg',
                ),
              ],
            ),
          ),
          Text(
            Utilities.currencyFormat(
              context.read<StoreDetailCubit>().newTotalPrice,
            ),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AlpacaColor.primary100,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildSelectButton({
    required void Function() onTap,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 11,
      ),
      child: Bounceable(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        child: Container(
          alignment: Alignment.center,
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: AlpacaColor.greyColor,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: SvgPicture.asset(
            imagePath,
            color: AlpacaColor.darkGreyColor,
          ),
        ),
      ),
    );
  }
}
