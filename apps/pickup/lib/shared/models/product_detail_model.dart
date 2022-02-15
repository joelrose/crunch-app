
import 'package:sanity/sanity.dart';

class ProductDetailsData {
  ProductDetailsData({
    required this.item,
    required this.restaurantImage,
    required this.checkoutItems,
    required this.onCheckoutChange,
  });
  final RestaurantMenueItemModel item;
  final String restaurantImage;
  List<CheckoutItemModel> checkoutItems;
  void Function(List<CheckoutItemModel>) onCheckoutChange;
}