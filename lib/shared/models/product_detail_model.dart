import 'package:hermes_api/hermes_api.dart';
import 'package:sanity/sanity.dart';

class ProductDetailsData {
  ProductDetailsData({
    required this.item,
    required this.restaurantImage,
    required this.checkoutItems,
    required this.onCheckoutChange,
  });
  final DeliverectProductModelDto item;
  final String restaurantImage;
  List<CheckoutItemModel> checkoutItems;
  void Function(List<CheckoutItemModel>) onCheckoutChange;
}
