import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';

class ProductAmountAndAddToOrder extends StatefulWidget {
  const ProductAmountAndAddToOrder({Key? key, required this.data})
      : super(key: key);
  final ProductDetailsData data;

  @override
  _ProductAmountAndAddToOrderState createState() =>
      _ProductAmountAndAddToOrderState();
}

class _ProductAmountAndAddToOrderState
    extends State<ProductAmountAndAddToOrder> {
  late int productAmount;
  late int productAmountInBasket;
  late double totalPrice;
  late String priceAsString;

  @override
  void initState() {
    super.initState();
    if (widget.data.checkoutItems.contains(widget.data.item)) {
      productAmount = widget.data.checkoutItems
          .where(
            (listItem) => widget.data.item == listItem,
          )
          .length;
      productAmountInBasket = productAmount;
      totalPrice = widget.data.item.price.toDouble() * productAmount;
    } else {
      productAmount = 1;
      productAmountInBasket = 0;
      totalPrice = widget.data.item.price.toDouble();
    }
    priceAsString = '${totalPrice.toStringAsFixed(2)}€';
  }

  @override
  Widget build(BuildContext context) {
    final productPrice = widget.data.item.price.toDouble();

    void updatePriceAsString(newTotalPrice) {
      setState(() {
        priceAsString = '$newTotalPrice€';
      });
    }

    void calculateNewPrice(int amount, double price) {
      final double newTotalPrice = productPrice * amount;
      setState(() {
        totalPrice = newTotalPrice;
      });
      updatePriceAsString(newTotalPrice.toStringAsFixed(2));
    }

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
                                if (productAmount != 0) {
                                  setState(() {
                                    productAmount -= 1;
                                  });
                                  calculateNewPrice(productAmount, totalPrice);
                                }
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
                              width: 35,
                              child: Text(
                                productAmount.toString(),
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
                                setState(() {
                                  productAmount += 1;
                                });
                                calculateNewPrice(
                                  productAmount,
                                  totalPrice,
                                );
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
                    if (productAmount > productAmountInBasket) {
                      for (var i = productAmountInBasket;
                          i < productAmount;
                          i++) {
                        widget.data.checkoutItems.add(widget.data.item);
                      }
                    }
                    if (productAmount < productAmountInBasket) {
                      for (var i = productAmountInBasket;
                          i > productAmount;
                          i--) {
                        widget.data.checkoutItems.remove(widget.data.item);
                      }
                    }

                    widget.data.onCheckoutChange(widget.data.checkoutItems);
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
  }
}
