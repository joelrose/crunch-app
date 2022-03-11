
import 'package:sanity/sanity.dart';

class CreateCheckoutData {
  CreateCheckoutData({
    required this.checkoutItems,
    required this.googleMaps,
    required this.pickupTime,
    required this.creationTime,
  });

  final List<CheckoutItemModel> checkoutItems;
  final String googleMaps;
  final DateTime pickupTime;
  final DateTime creationTime;
}
