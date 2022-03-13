import 'package:sanity/sanity.dart';
import 'check_out_item_amount.dart';

class CheckOutVM {
  CheckOutVM(List<CheckoutItemModel> checkoutItems) {
    groupItems(checkoutItems);
  }

  //each induvidual item with count
  List<CheckoutItemAmount> checkoutSummaryList = [];

  void groupItems(List<CheckoutItemModel> checkoutItems) {
    for (final item in checkoutItems) {
      addToSummary(item);
    }
  }

  void addToSummary(CheckoutItemModel item) {
    for (final summaryItem in checkoutSummaryList) {
      if (summaryItem.checkoutItem.plu == item.plu) {
        summaryItem.amount += 1;
        summaryItem.totalPrice += calculateItemPrice(item);
        return;
      }
    }

    checkoutSummaryList.add(
      CheckoutItemAmount(
        amount: 1,
        checkoutItem: item,
        totalPrice: item.price.toDouble(),
      ),
    );
  }

  double calculateItemPrice(CheckoutItemModel item) {
    double price = item.price.toDouble();
    for (final itemOption in item.itemOptionPlus) {
      price += itemOption.option.price;
    }
    return price;
  }
}
