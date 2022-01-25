import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';
import 'package:sanity/sanity.dart';

import '../widgets/store_menue_list.dart';
import 'product_amount_and_add_to_order.dart';
import 'product_detail_text.dart';
import 'product_radio_checkbox.dart';

class PriceData {
  PriceData({
    required this.totalItemPrice,
    required this.amountOfProductsToAddToBasket,
    required this.newTotalPrice,
  });
  double totalItemPrice;
  int amountOfProductsToAddToBasket;
  double newTotalPrice;
}

class ProductAmountAndPricesData {
  ProductAmountAndPricesData({
    required this.amountOfProductsToAddToBasket,
    required this.newTotalPrice,
    required this.increaseItemAmount,
    required this.decreaseItemAmount,
    required this.addToOrderOnClick,
  });
  int amountOfProductsToAddToBasket;
  double newTotalPrice;
  Function increaseItemAmount;
  Function decreaseItemAmount;
  Function addToOrderOnClick;
}

class StoreProductOverview extends StatefulWidget {
  const StoreProductOverview({Key? key, required this.data}) : super(key: key);
  final ProductDetailsData data;

  @override
  _StoreProductOverviewState createState() => _StoreProductOverviewState();
}

class _StoreProductOverviewState extends State<StoreProductOverview> {
  late int amountOfProductsToAddToBasket;
  late int productAmountInBasket;
  late double newTotalPrice;
  late double defaultItemPrice;
  late double totalItemPrice;
  late String priceAsString;
  late List itemAndOptionsList;

  @override
  void initState() {
    super.initState();

    defaultItemPrice = widget.data.item.price.toDouble();
    totalItemPrice = defaultItemPrice;

    bool ifItemInBasket() {
      if (widget.data.checkoutItems.indexWhere(
            (checkoutItem) => checkoutItem.id == widget.data.item.id,
          ) !=
          -1) {
        return true;
      } else {
        return false;
      }
    }

    productAmountInBasket = widget.data.checkoutItems
        .where(
          (listItem) => widget.data.item.id == listItem.id,
        )
        .length;

    if (ifItemInBasket()) {
      amountOfProductsToAddToBasket = productAmountInBasket;
    } else {
      amountOfProductsToAddToBasket = 1;
      productAmountInBasket = 0;
    }
    newTotalPrice = totalItemPrice * amountOfProductsToAddToBasket;

    final item = widget.data.item;
    itemAndOptionsList = [];
    if (item.itemOptions != null) {
      for (final itemOptions in item.itemOptions!) {
        final defaultOptionId = itemOptions.options[0].id;
        final itemAndValue = CheckoutOptionForItemOptionsModel(
          id: defaultOptionId,
          price: itemOptions.options[0].price,
          title: itemOptions.options[0].title,
        );
        itemAndOptionsList.add(itemAndValue);
      }
    }
  }

  void changeItemPrice(
    double singleProductPrice,
    double addOnPrice,
  ) {
    final double newItemPrice = singleProductPrice + addOnPrice;
    totalItemPrice = newItemPrice;
    calculateNewPrice(
      amountOfProductsToAddToBasket,
      newTotalPrice,
    );
  }

  void increaseItemAmount() {
    setState(() {
      amountOfProductsToAddToBasket += 1;
    });
    calculateNewPrice(
      amountOfProductsToAddToBasket,
      newTotalPrice,
    );
  }

  void decreaseItemAmount() {
    if (amountOfProductsToAddToBasket != 0) {
      setState(() {
        amountOfProductsToAddToBasket -= 1;
      });
      calculateNewPrice(
        amountOfProductsToAddToBasket,
        newTotalPrice,
      );
    }
  }

  void calculateNewPrice(int amount, double price) {
    setState(() {
      newTotalPrice = totalItemPrice * amount;
    });
  }

  void addToOrderOnClick() {
    final item = widget.data.item;
    if (amountOfProductsToAddToBasket > productAmountInBasket) {
      for (var i = productAmountInBasket;
          i < amountOfProductsToAddToBasket;
          i++) {
        widget.data.checkoutItems.add(
          CheckoutItemModel(
            id: item.id,
            itemOptions: CheckoutItemOptionsModel(
              options: CheckoutOptionForItemOptionsModel(
                id: item.itemOptions![0].options[0].id,
                price: item.itemOptions![0].options[0].price,
                title: item.itemOptions![0].options[0].title,
              ),
              title: item.itemOptions![0].title,
            ),
            price: item.price,
            title: item.title,
          ),
        );
      }
    }
    if (amountOfProductsToAddToBasket < productAmountInBasket) {
      print(productAmountInBasket);
      for (var i = productAmountInBasket;
          i > amountOfProductsToAddToBasket;
          i--) {
        widget.data.checkoutItems.removeWhere(
          (checkoutItem) => checkoutItem.id == widget.data.item.id,
        );
      }
    }

    widget.data.onCheckoutChange(widget.data.checkoutItems);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      statusBarStyle: SystemUiOverlayStyle.dark,
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
                        itemCategories: widget.data.item.itemOptions,
                        itemPrice: widget.data.item.price.toDouble(),
                        changeItemPrice: changeItemPrice,
                        itemAndOptionsList: itemAndOptionsList,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductAmountAndAddToOrder(
            data: widget.data,
            priceData: ProductAmountAndPricesData(
              amountOfProductsToAddToBasket: amountOfProductsToAddToBasket,
              newTotalPrice: newTotalPrice,
              increaseItemAmount: increaseItemAmount,
              decreaseItemAmount: decreaseItemAmount,
              addToOrderOnClick: addToOrderOnClick,
            ),
          )
        ],
      ),
    );
  }
}
