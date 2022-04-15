import 'package:hermes_api/hermes_api.dart';

class PriceCalulcation {
  static int getPriceOfItem(CreateOrderItemDto item) {
    assertItem(item);

    return item.quantity! * (getPriceOfItems(item.items) + (item.price!));
  }

  static int getPriceOfItems(List<CreateOrderItemDto>? items) {
    if (items == null || items.isEmpty) {
      return 0;
    }

    var optionPrice = 0;
    for (final item in items) {
      assertItem(item);

      optionPrice +=
          item.quantity! * (getPriceOfItems(item.items) + item.price!);
    }

    return optionPrice;
  }

  static void assertItem(CreateOrderItemDto item) {
    assert(item.quantity != null && item.quantity != 0);
    assert(item.price != null);
  }
}
