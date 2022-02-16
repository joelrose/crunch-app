import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/product_detail_order/product_details_main.dart';
import 'package:pickup/shared/models/product_detail_model.dart';

class ProductAmountAndAddToOrder extends StatefulWidget {
  const ProductAmountAndAddToOrder({
    Key? key,
    required this.data,
    required this.priceData,
  }) : super(key: key);
  final ProductDetailsData data;
  final ProductAmountAndPricesData priceData;

  @override
  _ProductAmountAndAddToOrderState createState() =>
      _ProductAmountAndAddToOrderState();
}

class _ProductAmountAndAddToOrderState
    extends State<ProductAmountAndAddToOrder> {
  @override
  Widget build(BuildContext context) {
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
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                widget.priceData.decreaseItemAmount();
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
                                widget.priceData.amountOfProductsToAddToBasket
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
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                widget.priceData.increaseItemAmount();
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
                      '${widget.priceData.newTotalPrice.toStringAsFixed(2)} €',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
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
                    widget.priceData.addToOrderOnClick();
                  },
                  buttonText: 'Add to order',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}