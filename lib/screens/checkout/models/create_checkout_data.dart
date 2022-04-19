import 'package:hermes_repository/hermes_repository.dart';

class CreateCheckoutData {
  CreateCheckoutData({
    required this.checkoutItems,
    required this.googleMaps,
    required this.pickupTime,
    required this.creationTime,
  });

  final List<CreateOrderItemDto> checkoutItems;
  final String googleMaps;
  final DateTime pickupTime;
  final DateTime creationTime;
}
