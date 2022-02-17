import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/product_detail_order/product_amount_and_add_to_order.dart';
import 'package:pickup/screens/store/product_detail_order/product_detail_text.dart';
import 'package:pickup/screens/store/product_detail_order/product_radio_checkbox.dart';
import 'package:pickup/shared/alpaca_stretchy_header.dart';
import 'package:pickup/shared/models/product_detail_model.dart';
import 'package:sanity/sanity.dart';

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
  static const route = '/store/product';

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
  late List<CheckoutItemOptionsModel> itemTitleAndOptionsList;
  late CheckoutItemOptionsModel itemTitleAndOptions;
  late CheckoutOptionForItemOptionsModel itemOption;

  @override
  void initState() {
    super.initState();

    bool isItemInBasket() {
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

    if (isItemInBasket()) {
      amountOfProductsToAddToBasket = productAmountInBasket;
    } else {
      amountOfProductsToAddToBasket = 1;
      productAmountInBasket = 0;
    }

    defaultItemPrice = widget.data.item.price.toDouble();
    totalItemPrice = defaultItemPrice;

    final item = widget.data.item;

    itemTitleAndOptionsList = [];
    if (widget.data.item.itemOptions != null) {
      if (!isItemInBasket()) {
        for (final itemOptions in item.itemOptions!) {
          itemOption = CheckoutOptionForItemOptionsModel(
            id: itemOptions.options[0].id,
            price: itemOptions.options[0].price,
            title: itemOptions.options[0].title,
          );
          itemTitleAndOptions = CheckoutItemOptionsModel(
            option: itemOption,
            title: itemOptions.title,
          );
          itemTitleAndOptionsList.add(itemTitleAndOptions);
        }
      } else {
        final int itemIndexInBasket = widget.data.checkoutItems.indexWhere(
          (checkoutItem) => checkoutItem.id == widget.data.item.id,
        );
        itemTitleAndOptionsList =
            widget.data.checkoutItems[itemIndexInBasket].itemOptions;

        double addOnPrice = 0;
        for (final item in itemTitleAndOptionsList) {
          final itemOptionPrice = item.option.price.toDouble();
          addOnPrice += itemOptionPrice;
        }
        totalItemPrice = defaultItemPrice + addOnPrice;
      }
    }

    newTotalPrice = totalItemPrice * amountOfProductsToAddToBasket;
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
    if (amountOfProductsToAddToBasket < productAmountInBasket) {
      for (var i = productAmountInBasket;
          i > amountOfProductsToAddToBasket;
          i--) {
        widget.data.checkoutItems.removeWhere(
          (checkoutItem) => checkoutItem.id == widget.data.item.id,
        );
        productAmountInBasket = 0;
      }
    }
    if (amountOfProductsToAddToBasket > productAmountInBasket) {
      for (var i = productAmountInBasket;
          i < amountOfProductsToAddToBasket;
          i++) {
        widget.data.checkoutItems.add(
          CheckoutItemModel(
            id: item.id,
            itemOptions: itemTitleAndOptionsList,
            price: item.price,
            title: item.title,
          ),
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
            child: AlpacaStretchyHeader(
              image: widget.data.restaurantImage,
              child: Column(
                children: [
                  // StoreImageNavbar(
                  //   image: widget.data.restaurantImage,
                  //   showButtons: false,
                  // ),
                  ProductBasicDetails(
                    itemPrice: widget.data.item.price,
                    title: widget.data.item.title.english,
                  ),
                  ProductRadioCheckbox(
                    itemCategories: widget.data.item.itemOptions,
                    itemPrice: widget.data.item.price.toDouble(),
                    changeItemPrice: changeItemPrice,
                    itemTitleAndOptionsList: itemTitleAndOptionsList,
                  )
                ],
              ),
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
