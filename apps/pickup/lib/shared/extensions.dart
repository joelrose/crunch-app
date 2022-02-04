import 'package:sanity/sanity.dart';

extension MenueCalculation on List<RestaurantMenueItemModel> {
  num getTotalPrice() {
    num subtotalPrice = 0;
    for (final item in this) {
      subtotalPrice += item.price;
    }
    return subtotalPrice;
  }
}
