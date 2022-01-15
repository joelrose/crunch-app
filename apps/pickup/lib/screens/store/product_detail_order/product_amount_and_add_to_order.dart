import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';

import 'product_details_main.dart';

class ProductAmountAndAddToOrder extends StatefulWidget {
  const ProductAmountAndAddToOrder({
    Key? key,
    required this.data,
    required this.amountAndPriceData,
  }) : super(key: key);
  final ProductDetailsData data;
  final ProductAmountAndPricesData amountAndPriceData;

  @override
  _ProductAmountAndAddToOrderState createState() =>
      _ProductAmountAndAddToOrderState();
}

class _ProductAmountAndAddToOrderState
    extends State<ProductAmountAndAddToOrder> {
  late String priceAsString;
  late double productPrice;

  @override
  void initState() {
    super.initState();
    priceAsString =
        '${widget.amountAndPriceData.newTotalPrice.toStringAsFixed(2)}€';

    productPrice = widget.amountAndPriceData.itemPrice;
  }

  void updatePriceAsString(newTotalPrice) {
    setState(() {
      priceAsString = '$newTotalPrice€';
    });
  }

  void calculateNewPrice(int amount, double price) {
    print(productPrice);
    setState(() {
      widget.amountAndPriceData.newTotalPrice = productPrice * amount;
    });
    updatePriceAsString(
      widget.amountAndPriceData.newTotalPrice.toStringAsFixed(2),
    );
  }

  void addToOrderOnClick() {
    if (widget.amountAndPriceData.amountOfProductsToAddToBasket >
        widget.amountAndPriceData.productAmountInBasket) {
      for (var i = widget.amountAndPriceData.productAmountInBasket;
          i < widget.amountAndPriceData.amountOfProductsToAddToBasket;
          i++) {
        widget.data.checkoutItems.add(widget.data.item);
      }
    }
    if (widget.amountAndPriceData.amountOfProductsToAddToBasket <
        widget.amountAndPriceData.productAmountInBasket) {
      for (var i = widget.amountAndPriceData.productAmountInBasket;
          i > widget.amountAndPriceData.amountOfProductsToAddToBasket;
          i--) {
        widget.data.checkoutItems.remove(widget.data.item);
      }
    }

    widget.data.onCheckoutChange(widget.data.checkoutItems);
    Navigator.pop(context);
  }

  void changeProductPrice(double newProductPrice) {
    setState(() {
      productPrice = newProductPrice;
    });
  }

  void increaseItemAmount() {
    setState(() {
      widget.amountAndPriceData.amountOfProductsToAddToBasket += 1;
    });
    calculateNewPrice(
      widget.amountAndPriceData.amountOfProductsToAddToBasket,
      widget.amountAndPriceData.newTotalPrice,
    );
  }

  void decreaseItemAmount() {
    if (widget.amountAndPriceData.amountOfProductsToAddToBasket != 0) {
      setState(() {
        widget.amountAndPriceData.amountOfProductsToAddToBasket -= 1;
      });
      calculateNewPrice(
        widget.amountAndPriceData.amountOfProductsToAddToBasket,
        widget.amountAndPriceData.newTotalPrice,
      );
    }
  }

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
                                decreaseItemAmount();
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
                                widget.amountAndPriceData
                                    .amountOfProductsToAddToBasket
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .merge(
                                      const TextStyle(
                                        color: AlpacaColor.blackColor,
                                      ),
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
                                increaseItemAmount();
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
                      priceAsString,
                      style: Theme.of(context).textTheme.headline2!.merge(
                            const TextStyle(
                              color: AlpacaColor.primary100,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ActionButton(
                  onPressed: () {
                    addToOrderOnClick();
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
