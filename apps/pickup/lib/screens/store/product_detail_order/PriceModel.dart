import 'package:flutter/material.dart';
import 'package:pickup/screens/store/widgets/store_menue_list.dart';

import 'product_details_main.dart';

class PriceModel extends ChangeNotifier {
  PriceModel({required this.data, required this.priceData});
  final PriceData priceData;
  final ProductDetailsData data;

  void changeItemPrice(
    double singleProductPrice,
    double addOnPrice,
  ) {
    final double newItemPrice = singleProductPrice + addOnPrice;
    priceData.totalItemPrice = newItemPrice;
    calculateNewPrice(
      priceData.amountOfProductsToAddToBasket,
      priceData.newTotalPrice,
    );
  }

  void increaseItemAmount() {
    priceData.amountOfProductsToAddToBasket += 1;
    calculateNewPrice(
      priceData.amountOfProductsToAddToBasket,
      priceData.newTotalPrice,
    );
  }

  void decreaseItemAmount() {
    if (priceData.amountOfProductsToAddToBasket != 0) {
      priceData.amountOfProductsToAddToBasket -= 1;
      calculateNewPrice(
        priceData.amountOfProductsToAddToBasket,
        priceData.newTotalPrice,
      );
    }
  }

  void calculateNewPrice(int amount, double price) {
    priceData.newTotalPrice = priceData.totalItemPrice * amount;
    notifyListeners();
  }
}