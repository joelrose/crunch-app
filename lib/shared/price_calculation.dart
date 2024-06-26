import 'package:hermes_repository/hermes_repository.dart';

class PriceCalulcation {
  static int getPriceOfItem(OrderItem item) {
    assertItem(item);

    return item.quantity! * (getPriceOfItems(item.subItems) + (item.price!));
  }

  static int getPriceOfItems(List<OrderItem>? items) {
    if (items == null || items.isEmpty) {
      return 0;
    }

    var optionPrice = 0;
    for (final item in items) {
      assertItem(item);

      optionPrice +=
          item.quantity! * (getPriceOfItems(item.subItems) + item.price!);
    }

    return optionPrice;
  }

  static void assertItem(OrderItem item) {
    assert(item.quantity != null && item.quantity != 0);
    assert(item.price != null);
  }
}
