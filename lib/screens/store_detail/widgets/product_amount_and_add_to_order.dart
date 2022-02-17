import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store_detail/cubit/store_detail_cubit.dart';

class ProductAmountAndAddToOrder extends StatefulWidget {
  const ProductAmountAndAddToOrder({Key? key}) : super(key: key);

  @override
  _ProductAmountAndAddToOrderState createState() =>
      _ProductAmountAndAddToOrderState();
}

class _ProductAmountAndAddToOrderState
    extends State<ProductAmountAndAddToOrder> {
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
                  Padding(
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 11,
                                ),
                                child: Bounceable(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    context
                                        .read<StoreDetailCubit>()
                                        .decreaseItemAmount();
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
                                      'assets/icons/minus.svg',
                                      color: AlpacaColor.darkGreyColor,
                                    ),
                                  ),
                                ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          color: AlpacaColor.darkNavyColor,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 11,
                                ),
                                child: Bounceable(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    context
                                        .read<StoreDetailCubit>()
                                        .increaseItemAmount();
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
                                      'assets/icons/plus.svg',
                                      color: AlpacaColor.darkGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${context.read<StoreDetailCubit>().newTotalPrice.toStringAsFixed(2)} €',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: AlpacaColor.primary100,
                                  ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ActionButton(
                      onPressed: () {
                        context.read<StoreDetailCubit>().addToOrderOnClick();
                        Navigator.pop(context);
                      },
                      buttonText: 'Add to order',
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
