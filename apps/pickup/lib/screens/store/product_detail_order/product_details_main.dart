import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/store/product_detail_order/PriceModel.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';
import 'package:provider/provider.dart';

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

  void addToOrderOnClick() {
    if (amountOfProductsToAddToBasket > productAmountInBasket) {
      for (var i = productAmountInBasket;
          i < amountOfProductsToAddToBasket;
          i++) {
        widget.data.checkoutItems.add(widget.data.item);
      }
    }
    if (amountOfProductsToAddToBasket < productAmountInBasket) {
      for (var i = productAmountInBasket;
          i > amountOfProductsToAddToBasket;
          i--) {
        widget.data.checkoutItems.remove(widget.data.item);
      }
    }

    widget.data.onCheckoutChange(widget.data.checkoutItems);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PriceModel(
        data: widget.data,
        priceData: PriceData(
          totalItemPrice: totalItemPrice,
          amountOfProductsToAddToBasket: amountOfProductsToAddToBasket,
          newTotalPrice: newTotalPrice,
        ),
      ),
      builder: (context, child) => PageWrapper(
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
                          changeItemPrice:
                              Provider.of<PriceModel>(context, listen: false)
                                  .changeItemPrice,
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
                increaseItemAmount:
                    Provider.of<PriceModel>(context, listen: false)
                        .increaseItemAmount,
                decreaseItemAmount:
                    Provider.of<PriceModel>(context, listen: false)
                        .decreaseItemAmount,
                addToOrderOnClick: addToOrderOnClick,
              ),
            )
          ],
        ),
      ),
    );
  }
}
