import 'dart:async';
import 'dart:convert';

import 'package:hermes_repository/hermes_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutItemNotFound implements Exception {}

class LocalStorageCheckoutApi {
  LocalStorageCheckoutApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _checkoutStreamController =
      BehaviorSubject<List<CreateOrderItemDto>>.seeded(const []);

  /// The key used for storing the checkout items locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kCheckoutCollectionKey = '__checkout_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final checkoutItemsJson = _getValue(kCheckoutCollectionKey);
    if (checkoutItemsJson != null) {
      final checkoutItems = List<Map>.from(
              json.decode(checkoutItemsJson) as List,)
          .map((jsonMap) =>
              CreateOrderItemDto.fromJson(Map<String, dynamic>.from(jsonMap)),)
          .toList();
      _checkoutStreamController.add(checkoutItems);
    } else {
      _checkoutStreamController.add(const []);
    }
  }

  Stream<List<CreateOrderItemDto>> getCheckoutItems() =>
      _checkoutStreamController.asBroadcastStream();

  Future<void> clear() async {
    _checkoutStreamController.value = [];
  }

  Future<void> deleteItemByIndex(int itemIndex) async {
    final items = [..._checkoutStreamController.value];

    items.removeAt(itemIndex);

    _checkoutStreamController.add(items);
    return _setValue(kCheckoutCollectionKey, json.encode(items));
  }

  Future<void> incrementItemQuantityByIndex(int itemIndex) async {
    final items = [..._checkoutStreamController.value];

    items[itemIndex].quantity = items[itemIndex].quantity! + 1;

    _checkoutStreamController.add(items);
    return _setValue(kCheckoutCollectionKey, json.encode(items));
  }

  Future<void> decrementItemQuantityByIndex(int itemIndex) async {
    final items = [..._checkoutStreamController.value];

    items[itemIndex].quantity = items[itemIndex].quantity! - 1;

    _checkoutStreamController.add(items);
    return _setValue(kCheckoutCollectionKey, json.encode(items));
  }

  Future<void> updateCheckoutItems(
    List<CreateOrderItemDto> checkoutItems,
  ) async {
    _checkoutStreamController.add(checkoutItems);
    return _setValue(kCheckoutCollectionKey, json.encode(checkoutItems));
  }
}
