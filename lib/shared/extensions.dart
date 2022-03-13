import 'package:hermes_api/hermes_api.dart';

class PriceCalulcation {
  // TODO: write tests
  static int getPriceOfItem(CreateOrderItemDto item) {
    return item.quantity! * (getPriceOfItems(item.items) + item.price!);
  }

  // TODO: check and write tests - watch out for the quantity
  static int getPriceOfItems(List<CreateOrderItemDto>? items) {
    if (items == null || items.isEmpty) {
      return 0;
    }

    var optionPrice = 0;
    for (final item in items) {
      optionPrice += getPriceOfItems(item.items) + item.price!;
    }

    return optionPrice;
  }
}
