import 'package:hermes_api/hermes_api.dart';

extension CreateOrderItemX on CreateOrderItemDto {
  bool equals(
    CreateOrderItemDto other,
  ) {
    final isEqual =
        plu == other.plu && price == other.price && name == other.name;

    return isEqual;
  }
}
