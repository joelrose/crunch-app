import 'package:hermes_api/hermes_api.dart';

extension OrderItemX on OrderItem {
  bool equals(
    OrderItem other,
  ) {
    final isEqual =
        plu == other.plu && price == other.price && name == other.name;

    return isEqual;
  }
}
