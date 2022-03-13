import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/checkout/models/check_out_item_amount.dart';

class CheckOutVM {
  CheckOutVM(List<CreateOrderItemDto> checkoutItems) {
    groupItems(checkoutItems);
  }

  //each induvidual item with count
  List<CheckoutItemAmount> checkoutSummaryList = [];

  void groupItems(List<CreateOrderItemDto> checkoutItems) {
    for (final item in checkoutItems) {
      addToSummary(item);
    }
  }

  void addToSummary(CreateOrderItemDto item) {

    // TODO: this can be removed
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
        totalPrice: item.price!,
      ),
    );
  }

  int calculateItemPrice(CreateOrderItemDto item) {
    int price = item.price!;
    if (item.items != null) {
      for (final itemOption in item.items!) {
        price += itemOption.price!;
      }
    }

    return price;
  }
}
