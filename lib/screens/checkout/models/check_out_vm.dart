
import 'package:sanity/sanity.dart';

import 'check_out_item_amount.dart';

class CheckOutVM {
  // TASK: Sumarise the checkout items by grouping same items and counting them

  CheckOutVM(List<CheckoutItemModel> checkoutItems) {
    groupItems(checkoutItems);
  }

  //each induvidual item with count
  List<CheckoutItemAmount> checkoutSummaryList = [];

  void groupItems(List<CheckoutItemModel> checkoutItems) {
    for (final item in checkoutItems) {
      if (!alreadyInList(checkoutSummaryList, item)) {
        // calculate
        final int amount = countInList(checkoutItems, item);
        final double itemPrice = calculateItemPrice(item);
        final double totalPrice = itemPrice * amount;
        // add
        checkoutSummaryList.add(
          CheckoutItemAmount(
            checkoutItem: item,
            amount: amount,
            totalPrice: totalPrice,
          ),
        );
      }
    }
  }

  double calculateItemPrice(CheckoutItemModel item) {
    double itemAddOnPrice = 0;
    for (final itemOption in item.itemOptions) {
      itemAddOnPrice += itemOption.option.price;
    }
    return item.price.toDouble() + itemAddOnPrice;
  }

  bool alreadyInList(
    List<CheckoutItemAmount> summaryList,
    CheckoutItemModel item,
  ) {
    if (summaryList.isEmpty) {
      return false;
    }
    for (final summaryItem in summaryList) {
      if (sameItem(summaryItem.checkoutItem, item)) {
        // if (identical(summaryItem.checkoutItem, item)) {
        return true;
      }
    }
    return false;
  }

  bool sameItem(CheckoutItemModel item1, CheckoutItemModel item2) {
    return item1.id == item2.id; //&& item1.itemOptions == item2.itemOptions;
  }

  int countInList(
    List<CheckoutItemModel> checkoutList,
    CheckoutItemModel item,
  ) {
    int count = 0;
    for (final itemInList in checkoutList) {
      if (itemInList.id == item.id) {
        count += 1;
      }
    }
    return count;
  }
}