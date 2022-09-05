import 'package:local_storage_checkout_api/local_storage_checkout_api.dart';

class CheckoutRepository {
  const CheckoutRepository({
    required LocalStorageCheckoutApi checkoutApi,
  }) : _checkoutApi = checkoutApi;

  final LocalStorageCheckoutApi _checkoutApi;

  /// Provides a [Stream] of all checkout items.
  Stream<List<CreateOrderItemDto>> getCheckoutItems() =>
      _checkoutApi.getCheckoutItems();

  Future<void> deleteItem(int itemIndex) =>
      _checkoutApi.deleteItemByIndex(itemIndex);

  Future<void> decrementItemQuantity(int itemIndex) =>
      _checkoutApi.decrementItemQuantityByIndex(itemIndex);

  Future<void> incrementItemQuantity(int itemIndex) =>
      _checkoutApi.incrementItemQuantityByIndex(itemIndex);

  Future<void> addItem(CreateOrderItemDto item) =>
      _checkoutApi.addItem(item);

  Future<void> clear() =>
      _checkoutApi.clear();
}
