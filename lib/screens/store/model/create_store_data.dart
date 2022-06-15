import 'package:hermes_repository/hermes_repository.dart';

class CreateStoreData {
  CreateStoreData({
    required this.checkoutItems,
    required this.storeName,
    required this.googleMaps,
    required this.merchantId,
  });

  final List<CreateOrderItemDto> checkoutItems;
  final String storeName;
  final String googleMaps;
  final String merchantId;
}
