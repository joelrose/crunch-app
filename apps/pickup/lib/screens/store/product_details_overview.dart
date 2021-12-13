import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';

import 'widgets/store_menue_list.dart';

class StoreProductOverview extends StatefulWidget {
  StoreProductOverview({Key? key, required this.data}) : super(key: key);
  ProductDetailsData data;

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
                      ProductRadioCheckbox()
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductAmountAndAddToOrder(data: widget.data,)
        ],
      ),
    );
  }
}

class ProductBasicDetails extends StatelessWidget {
  ProductBasicDetails({Key? key, required this.title}) : super(key: key);
  String title;

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
  ProductRadioCheckbox({Key? key}) : super(key: key);
  List<Map<String, Object>> itemData = [
    {
      'Topic': 'Size',
      'Choices': [
        ['Medium', ''],
        ['Large', '+1.10€'],
      ]
    },
    {
      'Topic': 'Hot sauce',
      'Choices': [
        ['No', ''],
        ['Yes', ''],
      ]
    },
    {
      'Topic': 'Hot sauce',
      'Choices': [
        ['No', ''],
        ['Yes', ''],
      ]
    },
  ];

  @override
  _ProductRadioCheckboxState createState() => _ProductRadioCheckboxState();
}

class _ProductRadioCheckboxState extends State<ProductRadioCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.itemData.length,
        itemBuilder: (context, i) {
          final Map<dynamic, dynamic> item = widget.itemData[i];
          final String itemTopic = item['Topic'] as String;
          final List<dynamic> itemChoices = item['Choices'] as List;
          String initialChoice = itemChoices[0].toString();
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemTopic,
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
                        itemCount: itemChoices.length,
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
                            final value = itemChoices[index];
                            setState(() {
                              initialChoice = value.toString();
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: itemChoices[index].toString(),
                                groupValue: initialChoice,
                                onChanged: (value) {
                                  setState(() {
                                    initialChoice = value.toString();
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
                                        itemChoices[index][0].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                color:
                                                    AlpacaColor.darkNavyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        itemChoices[index][1].toString(),
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
      ),
    );
  }
}

class ProductAmountAndAddToOrder extends StatefulWidget {
  ProductAmountAndAddToOrder({Key? key, required this.data}) : super(key: key);
  ProductDetailsData data;

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
    double productPrice = widget.data.item.price.toDouble();

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
