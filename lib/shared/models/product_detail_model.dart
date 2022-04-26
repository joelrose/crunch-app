import 'package:hermes_repository/hermes_repository.dart';

class ProductDetailsData {
  ProductDetailsData({
    required this.item,
    required this.restaurantImage,
    required this.checkoutItems,
    required this.onCheckoutChange,
  });
  final DeliverectProductModelDto item;
  final String restaurantImage;
  List<CreateOrderItemDto> checkoutItems;
  void Function(List<CreateOrderItemDto>) onCheckoutChange;
}
