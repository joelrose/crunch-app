import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';

import '../widgets/store_menue_list.dart';
import 'product_amount_and_add_to_order.dart';
import 'product_detail_text.dart';
import 'product_radio_checkbox.dart';

class ProductAmountAndPricesData {
  ProductAmountAndPricesData({
    required this.amountOfProductsToAddToBasket,
    required this.productAmountInBasket,
    required this.newTotalPrice,
    required this.itemPrice,
  });
  int amountOfProductsToAddToBasket;
  int productAmountInBasket;
  double newTotalPrice;
  double itemPrice;
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

  @override
  void initState() {
    super.initState();

    defaultItemPrice = widget.data.item.price.toDouble();
    totalItemPrice = defaultItemPrice;

    final bool ifItemInBasket =
        widget.data.checkoutItems.contains(widget.data.item);

    productAmountInBasket = widget.data.checkoutItems
        .where(
          (listItem) => widget.data.item == listItem,
        )
        .length;

    if (ifItemInBasket) {
      amountOfProductsToAddToBasket = productAmountInBasket;
    } else {
      amountOfProductsToAddToBasket = 1;
      productAmountInBasket = 0;
    }
    newTotalPrice = totalItemPrice * amountOfProductsToAddToBasket;
  }

  void changeItemPrice(
    double singleProductPrice,
    double addOnPrice,
  ) {
    final double newItemPrice = singleProductPrice + addOnPrice;
    // wenn ich hier setState mache baut er alle childs neu
    // setState(() {
      totalItemPrice = newItemPrice;
    // });
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
                        itemCategories: widget.data.itemOptions,
                        itemPrice: widget.data.item.price.toDouble(),
                        changeItemPrice: changeItemPrice,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductAmountAndAddToOrder(
            data: widget.data,
            amountAndPriceData: ProductAmountAndPricesData(
              amountOfProductsToAddToBasket: amountOfProductsToAddToBasket,
              productAmountInBasket: productAmountInBasket,
              newTotalPrice: newTotalPrice,
              itemPrice: totalItemPrice,
            ),
          )
        ],
      ),
    );
  }
}
