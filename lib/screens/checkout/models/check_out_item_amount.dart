
import 'package:hermes_api/swagger_generated_code/swagger.swagger.dart';

class CheckoutItemAmount {
  CheckoutItemAmount({
    required this.checkoutItem,
    required this.amount,
    required this.totalPrice,
  });
  CreateOrderItemDto checkoutItem;
  int amount;
  int totalPrice;
}
