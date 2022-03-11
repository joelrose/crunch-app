
import 'package:sanity/sanity.dart';

class CheckoutItemAmount {
  CheckoutItemAmount({
    required this.checkoutItem,
    required this.amount,
    required this.totalPrice,
  });
  CheckoutItemModel checkoutItem;
  int amount;
  double totalPrice;
}
