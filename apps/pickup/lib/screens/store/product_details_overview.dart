import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';
import 'package:sanity/sanity.dart';

import 'widgets/store_menue_list.dart';

class StoreProductOverview extends StatefulWidget {
  const StoreProductOverview({Key? key, required this.data}) : super(key: key);
  final ProductDetailsData data;

  @override
  _StoreProductOverviewState createState() => _StoreProductOverviewState();
}

class _StoreProductOverviewState extends State<StoreProductOverview> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      StoreImageNavbar(
                        image: widget.data.restaurantImage,
                        showButtons: false,
                      ),
                      ProductBasicDetails(
                        title: widget.data.item.title.english,
                      ),
                      ProductRadioCheckbox(
                        itemCategories: widget.data.itemOptions,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductAmountAndAddToOrder(
            data: widget.data,
          )
        ],
      ),
    );
  }
}

class ProductBasicDetails extends StatelessWidget {
  const ProductBasicDetails({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .merge(const TextStyle(fontSize: 22)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Example description! Should be changed when basic details are available',
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}

class ProductRadioCheckbox extends StatefulWidget {
  const ProductRadioCheckbox({Key? key, required this.itemCategories})
      : super(key: key);
  final List<RestaurantMenueItemOptions>? itemCategories;

  @override
  _ProductRadioCheckboxState createState() => _ProductRadioCheckboxState();
}

class _ProductRadioCheckboxState extends State<ProductRadioCheckbox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.itemCategories?.length ?? 0,
      itemBuilder: (context, i) {
        final item = widget.itemCategories![i];
        var choice = item.options[0].id;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.english,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: AlpacaColor.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      itemCount: item.options.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, index) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            choice = item.options[index].id;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              value: item.options[index].id,
                              groupValue: choice,
                              onChanged: (value) {
                                setState(() {
                                  choice = value.toString();
                                });
                              },
                              activeColor: AlpacaColor.primary100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.options[index].title.english,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .merge(
                                            const TextStyle(
                                              color: AlpacaColor.darkNavyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                    ),
                                    if (item.options[index].price != 0)
                                      Text(
                                        '+ ${item.options[index].price.toString()}€',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                color: AlpacaColor.primary100,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

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
