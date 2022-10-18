// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'swagger.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateOrderRequest {
  CreateOrderRequest({
    this.orderItems,
    this.storeId,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);

  @JsonKey(
      name: 'orderItems', includeIfNull: false, defaultValue: <OrderItem>[])
  final List<OrderItem>? orderItems;
  @JsonKey(name: 'storeId', includeIfNull: false)
  final String? storeId;
  static const fromJsonFactory = _$CreateOrderRequestFromJson;
  static const toJsonFactory = _$CreateOrderRequestToJson;
  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderRequest &&
            (identical(other.orderItems, orderItems) ||
                const DeepCollectionEquality()
                    .equals(other.orderItems, orderItems)) &&
            (identical(other.storeId, storeId) ||
                const DeepCollectionEquality().equals(other.storeId, storeId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(orderItems) ^
      const DeepCollectionEquality().hash(storeId) ^
      runtimeType.hashCode;
}

extension $CreateOrderRequestExtension on CreateOrderRequest {
  CreateOrderRequest copyWith({List<OrderItem>? orderItems, String? storeId}) {
    return CreateOrderRequest(
        orderItems: orderItems ?? this.orderItems,
        storeId: storeId ?? this.storeId);
  }

  CreateOrderRequest copyWithWrapped(
      {Wrapped<List<OrderItem>?>? orderItems, Wrapped<String?>? storeId}) {
    return CreateOrderRequest(
        orderItems: (orderItems != null ? orderItems.value : this.orderItems),
        storeId: (storeId != null ? storeId.value : this.storeId));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderResponse {
  CreateOrderResponse({
    this.stripeClientSecret,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);

  @JsonKey(name: 'stripeClientSecret', includeIfNull: false)
  final String? stripeClientSecret;
  static const fromJsonFactory = _$CreateOrderResponseFromJson;
  static const toJsonFactory = _$CreateOrderResponseToJson;
  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderResponse &&
            (identical(other.stripeClientSecret, stripeClientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.stripeClientSecret, stripeClientSecret)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(stripeClientSecret) ^
      runtimeType.hashCode;
}

extension $CreateOrderResponseExtension on CreateOrderResponse {
  CreateOrderResponse copyWith({String? stripeClientSecret}) {
    return CreateOrderResponse(
        stripeClientSecret: stripeClientSecret ?? this.stripeClientSecret);
  }

  CreateOrderResponse copyWithWrapped({Wrapped<String?>? stripeClientSecret}) {
    return CreateOrderResponse(
        stripeClientSecret: (stripeClientSecret != null
            ? stripeClientSecret.value
            : this.stripeClientSecret));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateUserRequest {
  CreateUserRequest({
    required this.firstname,
    required this.languageCode,
    required this.lastname,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  @JsonKey(name: 'firstname', includeIfNull: false)
  final String firstname;
  @JsonKey(name: 'language_code', includeIfNull: false)
  final String languageCode;
  @JsonKey(name: 'lastname', includeIfNull: false)
  final String lastname;
  static const fromJsonFactory = _$CreateUserRequestFromJson;
  static const toJsonFactory = _$CreateUserRequestToJson;
  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateUserRequest &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.languageCode, languageCode) ||
                const DeepCollectionEquality()
                    .equals(other.languageCode, languageCode)) &&
            (identical(other.lastname, lastname) ||
                const DeepCollectionEquality()
                    .equals(other.lastname, lastname)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(languageCode) ^
      const DeepCollectionEquality().hash(lastname) ^
      runtimeType.hashCode;
}

extension $CreateUserRequestExtension on CreateUserRequest {
  CreateUserRequest copyWith(
      {String? firstname, String? languageCode, String? lastname}) {
    return CreateUserRequest(
        firstname: firstname ?? this.firstname,
        languageCode: languageCode ?? this.languageCode,
        lastname: lastname ?? this.lastname);
  }

  CreateUserRequest copyWithWrapped(
      {Wrapped<String>? firstname,
      Wrapped<String>? languageCode,
      Wrapped<String>? lastname}) {
    return CreateUserRequest(
        firstname: (firstname != null ? firstname.value : this.firstname),
        languageCode:
            (languageCode != null ? languageCode.value : this.languageCode),
        lastname: (lastname != null ? lastname.value : this.lastname));
  }
}

@JsonSerializable(explicitToJson: true)
class GetOrdersResponse {
  GetOrdersResponse({
    this.createdAt,
    this.estimatedPickupTime,
    this.googleMapsLink,
    this.id,
    this.isPaid,
    this.orderItems,
    this.price,
    this.status,
    this.storeAddress,
    this.storeDescription,
    this.storeImageUrl,
    this.storeName,
    this.storePhoneNumber,
  });

  factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersResponseFromJson(json);

  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'estimatedPickupTime', includeIfNull: false)
  final String? estimatedPickupTime;
  @JsonKey(name: 'googleMapsLink', includeIfNull: false)
  final String? googleMapsLink;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'isPaid', includeIfNull: false)
  final bool? isPaid;
  @JsonKey(
      name: 'orderItems', includeIfNull: false, defaultValue: <OrderItem>[])
  final List<OrderItem>? orderItems;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'status', includeIfNull: false)
  final int? status;
  @JsonKey(name: 'storeAddress', includeIfNull: false)
  final String? storeAddress;
  @JsonKey(name: 'storeDescription', includeIfNull: false)
  final String? storeDescription;
  @JsonKey(name: 'storeImageUrl', includeIfNull: false)
  final String? storeImageUrl;
  @JsonKey(name: 'storeName', includeIfNull: false)
  final String? storeName;
  @JsonKey(name: 'storePhoneNumber', includeIfNull: false)
  final String? storePhoneNumber;
  static const fromJsonFactory = _$GetOrdersResponseFromJson;
  static const toJsonFactory = _$GetOrdersResponseToJson;
  Map<String, dynamic> toJson() => _$GetOrdersResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetOrdersResponse &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.estimatedPickupTime, estimatedPickupTime) ||
                const DeepCollectionEquality()
                    .equals(other.estimatedPickupTime, estimatedPickupTime)) &&
            (identical(other.googleMapsLink, googleMapsLink) ||
                const DeepCollectionEquality()
                    .equals(other.googleMapsLink, googleMapsLink)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isPaid, isPaid) ||
                const DeepCollectionEquality().equals(other.isPaid, isPaid)) &&
            (identical(other.orderItems, orderItems) ||
                const DeepCollectionEquality()
                    .equals(other.orderItems, orderItems)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.storeAddress, storeAddress) ||
                const DeepCollectionEquality()
                    .equals(other.storeAddress, storeAddress)) &&
            (identical(other.storeDescription, storeDescription) ||
                const DeepCollectionEquality()
                    .equals(other.storeDescription, storeDescription)) &&
            (identical(other.storeImageUrl, storeImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.storeImageUrl, storeImageUrl)) &&
            (identical(other.storeName, storeName) ||
                const DeepCollectionEquality()
                    .equals(other.storeName, storeName)) &&
            (identical(other.storePhoneNumber, storePhoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.storePhoneNumber, storePhoneNumber)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(estimatedPickupTime) ^
      const DeepCollectionEquality().hash(googleMapsLink) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isPaid) ^
      const DeepCollectionEquality().hash(orderItems) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(storeAddress) ^
      const DeepCollectionEquality().hash(storeDescription) ^
      const DeepCollectionEquality().hash(storeImageUrl) ^
      const DeepCollectionEquality().hash(storeName) ^
      const DeepCollectionEquality().hash(storePhoneNumber) ^
      runtimeType.hashCode;
}

extension $GetOrdersResponseExtension on GetOrdersResponse {
  GetOrdersResponse copyWith(
      {String? createdAt,
      String? estimatedPickupTime,
      String? googleMapsLink,
      String? id,
      bool? isPaid,
      List<OrderItem>? orderItems,
      int? price,
      int? status,
      String? storeAddress,
      String? storeDescription,
      String? storeImageUrl,
      String? storeName,
      String? storePhoneNumber}) {
    return GetOrdersResponse(
        createdAt: createdAt ?? this.createdAt,
        estimatedPickupTime: estimatedPickupTime ?? this.estimatedPickupTime,
        googleMapsLink: googleMapsLink ?? this.googleMapsLink,
        id: id ?? this.id,
        isPaid: isPaid ?? this.isPaid,
        orderItems: orderItems ?? this.orderItems,
        price: price ?? this.price,
        status: status ?? this.status,
        storeAddress: storeAddress ?? this.storeAddress,
        storeDescription: storeDescription ?? this.storeDescription,
        storeImageUrl: storeImageUrl ?? this.storeImageUrl,
        storeName: storeName ?? this.storeName,
        storePhoneNumber: storePhoneNumber ?? this.storePhoneNumber);
  }

  GetOrdersResponse copyWithWrapped(
      {Wrapped<String?>? createdAt,
      Wrapped<String?>? estimatedPickupTime,
      Wrapped<String?>? googleMapsLink,
      Wrapped<String?>? id,
      Wrapped<bool?>? isPaid,
      Wrapped<List<OrderItem>?>? orderItems,
      Wrapped<int?>? price,
      Wrapped<int?>? status,
      Wrapped<String?>? storeAddress,
      Wrapped<String?>? storeDescription,
      Wrapped<String?>? storeImageUrl,
      Wrapped<String?>? storeName,
      Wrapped<String?>? storePhoneNumber}) {
    return GetOrdersResponse(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        estimatedPickupTime: (estimatedPickupTime != null
            ? estimatedPickupTime.value
            : this.estimatedPickupTime),
        googleMapsLink: (googleMapsLink != null
            ? googleMapsLink.value
            : this.googleMapsLink),
        id: (id != null ? id.value : this.id),
        isPaid: (isPaid != null ? isPaid.value : this.isPaid),
        orderItems: (orderItems != null ? orderItems.value : this.orderItems),
        price: (price != null ? price.value : this.price),
        status: (status != null ? status.value : this.status),
        storeAddress:
            (storeAddress != null ? storeAddress.value : this.storeAddress),
        storeDescription: (storeDescription != null
            ? storeDescription.value
            : this.storeDescription),
        storeImageUrl:
            (storeImageUrl != null ? storeImageUrl.value : this.storeImageUrl),
        storeName: (storeName != null ? storeName.value : this.storeName),
        storePhoneNumber: (storePhoneNumber != null
            ? storePhoneNumber.value
            : this.storePhoneNumber));
  }
}

@JsonSerializable(explicitToJson: true)
class GetStoreCategory {
  GetStoreCategory({
    this.description,
    this.id,
    this.imageUrl,
    this.name,
    this.products,
    this.sortOrder,
  });

  factory GetStoreCategory.fromJson(Map<String, dynamic> json) =>
      _$GetStoreCategoryFromJson(json);

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(
      name: 'products', includeIfNull: false, defaultValue: <GetStoreProduct>[])
  final List<GetStoreProduct>? products;
  @JsonKey(name: 'sortOrder', includeIfNull: false)
  final int? sortOrder;
  static const fromJsonFactory = _$GetStoreCategoryFromJson;
  static const toJsonFactory = _$GetStoreCategoryToJson;
  Map<String, dynamic> toJson() => _$GetStoreCategoryToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetStoreCategory &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)) &&
            (identical(other.sortOrder, sortOrder) ||
                const DeepCollectionEquality()
                    .equals(other.sortOrder, sortOrder)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(products) ^
      const DeepCollectionEquality().hash(sortOrder) ^
      runtimeType.hashCode;
}

extension $GetStoreCategoryExtension on GetStoreCategory {
  GetStoreCategory copyWith(
      {String? description,
      String? id,
      String? imageUrl,
      String? name,
      List<GetStoreProduct>? products,
      int? sortOrder}) {
    return GetStoreCategory(
        description: description ?? this.description,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        name: name ?? this.name,
        products: products ?? this.products,
        sortOrder: sortOrder ?? this.sortOrder);
  }

  GetStoreCategory copyWithWrapped(
      {Wrapped<String?>? description,
      Wrapped<String?>? id,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? name,
      Wrapped<List<GetStoreProduct>?>? products,
      Wrapped<int?>? sortOrder}) {
    return GetStoreCategory(
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        name: (name != null ? name.value : this.name),
        products: (products != null ? products.value : this.products),
        sortOrder: (sortOrder != null ? sortOrder.value : this.sortOrder));
  }
}

@JsonSerializable(explicitToJson: true)
class GetStoreOpeningHour {
  GetStoreOpeningHour({
    this.dayOfWeek,
    this.endTimestamp,
    this.startTimestamp,
  });

  factory GetStoreOpeningHour.fromJson(Map<String, dynamic> json) =>
      _$GetStoreOpeningHourFromJson(json);

  @JsonKey(name: 'dayOfWeek', includeIfNull: false)
  final int? dayOfWeek;
  @JsonKey(name: 'endTimestamp', includeIfNull: false)
  final int? endTimestamp;
  @JsonKey(name: 'startTimestamp', includeIfNull: false)
  final int? startTimestamp;
  static const fromJsonFactory = _$GetStoreOpeningHourFromJson;
  static const toJsonFactory = _$GetStoreOpeningHourToJson;
  Map<String, dynamic> toJson() => _$GetStoreOpeningHourToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetStoreOpeningHour &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfWeek, dayOfWeek)) &&
            (identical(other.endTimestamp, endTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.endTimestamp, endTimestamp)) &&
            (identical(other.startTimestamp, startTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.startTimestamp, startTimestamp)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dayOfWeek) ^
      const DeepCollectionEquality().hash(endTimestamp) ^
      const DeepCollectionEquality().hash(startTimestamp) ^
      runtimeType.hashCode;
}

extension $GetStoreOpeningHourExtension on GetStoreOpeningHour {
  GetStoreOpeningHour copyWith(
      {int? dayOfWeek, int? endTimestamp, int? startTimestamp}) {
    return GetStoreOpeningHour(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        endTimestamp: endTimestamp ?? this.endTimestamp,
        startTimestamp: startTimestamp ?? this.startTimestamp);
  }

  GetStoreOpeningHour copyWithWrapped(
      {Wrapped<int?>? dayOfWeek,
      Wrapped<int?>? endTimestamp,
      Wrapped<int?>? startTimestamp}) {
    return GetStoreOpeningHour(
        dayOfWeek: (dayOfWeek != null ? dayOfWeek.value : this.dayOfWeek),
        endTimestamp:
            (endTimestamp != null ? endTimestamp.value : this.endTimestamp),
        startTimestamp: (startTimestamp != null
            ? startTimestamp.value
            : this.startTimestamp));
  }
}

@JsonSerializable(explicitToJson: true)
class GetStoreProduct {
  GetStoreProduct({
    this.description,
    this.id,
    this.imageUrl,
    this.max,
    this.min,
    this.multiMax,
    this.multiply,
    this.name,
    this.plu,
    this.price,
    this.productType,
    this.products,
    this.snoozed,
    this.sortOrder,
    this.tax,
    this.visible,
  });

  factory GetStoreProduct.fromJson(Map<String, dynamic> json) =>
      _$GetStoreProductFromJson(json);

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'max', includeIfNull: false)
  final int? max;
  @JsonKey(name: 'min', includeIfNull: false)
  final int? min;
  @JsonKey(name: 'multiMax', includeIfNull: false)
  final int? multiMax;
  @JsonKey(name: 'multiply', includeIfNull: false)
  final int? multiply;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'plu', includeIfNull: false)
  final String? plu;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'productType', includeIfNull: false)
  final int? productType;
  @JsonKey(
      name: 'products', includeIfNull: false, defaultValue: <GetStoreProduct>[])
  final List<GetStoreProduct>? products;
  @JsonKey(name: 'snoozed', includeIfNull: false)
  final bool? snoozed;
  @JsonKey(name: 'sortOrder', includeIfNull: false)
  final int? sortOrder;
  @JsonKey(name: 'tax', includeIfNull: false)
  final int? tax;
  @JsonKey(name: 'visible', includeIfNull: false)
  final bool? visible;
  static const fromJsonFactory = _$GetStoreProductFromJson;
  static const toJsonFactory = _$GetStoreProductToJson;
  Map<String, dynamic> toJson() => _$GetStoreProductToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetStoreProduct &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.multiMax, multiMax) ||
                const DeepCollectionEquality()
                    .equals(other.multiMax, multiMax)) &&
            (identical(other.multiply, multiply) ||
                const DeepCollectionEquality()
                    .equals(other.multiply, multiply)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.plu, plu) ||
                const DeepCollectionEquality().equals(other.plu, plu)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.productType, productType) ||
                const DeepCollectionEquality()
                    .equals(other.productType, productType)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)) &&
            (identical(other.snoozed, snoozed) ||
                const DeepCollectionEquality()
                    .equals(other.snoozed, snoozed)) &&
            (identical(other.sortOrder, sortOrder) ||
                const DeepCollectionEquality()
                    .equals(other.sortOrder, sortOrder)) &&
            (identical(other.tax, tax) ||
                const DeepCollectionEquality().equals(other.tax, tax)) &&
            (identical(other.visible, visible) ||
                const DeepCollectionEquality().equals(other.visible, visible)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(multiMax) ^
      const DeepCollectionEquality().hash(multiply) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(plu) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(productType) ^
      const DeepCollectionEquality().hash(products) ^
      const DeepCollectionEquality().hash(snoozed) ^
      const DeepCollectionEquality().hash(sortOrder) ^
      const DeepCollectionEquality().hash(tax) ^
      const DeepCollectionEquality().hash(visible) ^
      runtimeType.hashCode;
}

extension $GetStoreProductExtension on GetStoreProduct {
  GetStoreProduct copyWith(
      {String? description,
      String? id,
      String? imageUrl,
      int? max,
      int? min,
      int? multiMax,
      int? multiply,
      String? name,
      String? plu,
      int? price,
      int? productType,
      List<GetStoreProduct>? products,
      bool? snoozed,
      int? sortOrder,
      int? tax,
      bool? visible}) {
    return GetStoreProduct(
        description: description ?? this.description,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        max: max ?? this.max,
        min: min ?? this.min,
        multiMax: multiMax ?? this.multiMax,
        multiply: multiply ?? this.multiply,
        name: name ?? this.name,
        plu: plu ?? this.plu,
        price: price ?? this.price,
        productType: productType ?? this.productType,
        products: products ?? this.products,
        snoozed: snoozed ?? this.snoozed,
        sortOrder: sortOrder ?? this.sortOrder,
        tax: tax ?? this.tax,
        visible: visible ?? this.visible);
  }

  GetStoreProduct copyWithWrapped(
      {Wrapped<String?>? description,
      Wrapped<String?>? id,
      Wrapped<String?>? imageUrl,
      Wrapped<int?>? max,
      Wrapped<int?>? min,
      Wrapped<int?>? multiMax,
      Wrapped<int?>? multiply,
      Wrapped<String?>? name,
      Wrapped<String?>? plu,
      Wrapped<int?>? price,
      Wrapped<int?>? productType,
      Wrapped<List<GetStoreProduct>?>? products,
      Wrapped<bool?>? snoozed,
      Wrapped<int?>? sortOrder,
      Wrapped<int?>? tax,
      Wrapped<bool?>? visible}) {
    return GetStoreProduct(
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        max: (max != null ? max.value : this.max),
        min: (min != null ? min.value : this.min),
        multiMax: (multiMax != null ? multiMax.value : this.multiMax),
        multiply: (multiply != null ? multiply.value : this.multiply),
        name: (name != null ? name.value : this.name),
        plu: (plu != null ? plu.value : this.plu),
        price: (price != null ? price.value : this.price),
        productType:
            (productType != null ? productType.value : this.productType),
        products: (products != null ? products.value : this.products),
        snoozed: (snoozed != null ? snoozed.value : this.snoozed),
        sortOrder: (sortOrder != null ? sortOrder.value : this.sortOrder),
        tax: (tax != null ? tax.value : this.tax),
        visible: (visible != null ? visible.value : this.visible));
  }
}

@JsonSerializable(explicitToJson: true)
class GetStoreResponse {
  GetStoreResponse({
    this.address,
    this.averagePickupTime,
    this.averageReview,
    this.categories,
    this.description,
    this.googleMapsLink,
    this.id,
    this.imageUrl,
    this.name,
    this.openingHours,
    this.phoneNumber,
    this.reviewCount,
  });

  factory GetStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$GetStoreResponseFromJson(json);

  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'averagePickupTime', includeIfNull: false)
  final int? averagePickupTime;
  @JsonKey(name: 'averageReview', includeIfNull: false)
  final double? averageReview;
  @JsonKey(
      name: 'categories',
      includeIfNull: false,
      defaultValue: <GetStoreCategory>[])
  final List<GetStoreCategory>? categories;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'googleMapsLink', includeIfNull: false)
  final String? googleMapsLink;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(
      name: 'openingHours',
      includeIfNull: false,
      defaultValue: <GetStoreOpeningHour>[])
  final List<GetStoreOpeningHour>? openingHours;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'reviewCount', includeIfNull: false)
  final int? reviewCount;
  static const fromJsonFactory = _$GetStoreResponseFromJson;
  static const toJsonFactory = _$GetStoreResponseToJson;
  Map<String, dynamic> toJson() => _$GetStoreResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetStoreResponse &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.averagePickupTime, averagePickupTime) ||
                const DeepCollectionEquality()
                    .equals(other.averagePickupTime, averagePickupTime)) &&
            (identical(other.averageReview, averageReview) ||
                const DeepCollectionEquality()
                    .equals(other.averageReview, averageReview)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.googleMapsLink, googleMapsLink) ||
                const DeepCollectionEquality()
                    .equals(other.googleMapsLink, googleMapsLink)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.openingHours, openingHours) ||
                const DeepCollectionEquality()
                    .equals(other.openingHours, openingHours)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.reviewCount, reviewCount) ||
                const DeepCollectionEquality()
                    .equals(other.reviewCount, reviewCount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(averagePickupTime) ^
      const DeepCollectionEquality().hash(averageReview) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(googleMapsLink) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(openingHours) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(reviewCount) ^
      runtimeType.hashCode;
}

extension $GetStoreResponseExtension on GetStoreResponse {
  GetStoreResponse copyWith(
      {String? address,
      int? averagePickupTime,
      double? averageReview,
      List<GetStoreCategory>? categories,
      String? description,
      String? googleMapsLink,
      String? id,
      String? imageUrl,
      String? name,
      List<GetStoreOpeningHour>? openingHours,
      String? phoneNumber,
      int? reviewCount}) {
    return GetStoreResponse(
        address: address ?? this.address,
        averagePickupTime: averagePickupTime ?? this.averagePickupTime,
        averageReview: averageReview ?? this.averageReview,
        categories: categories ?? this.categories,
        description: description ?? this.description,
        googleMapsLink: googleMapsLink ?? this.googleMapsLink,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        name: name ?? this.name,
        openingHours: openingHours ?? this.openingHours,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        reviewCount: reviewCount ?? this.reviewCount);
  }

  GetStoreResponse copyWithWrapped(
      {Wrapped<String?>? address,
      Wrapped<int?>? averagePickupTime,
      Wrapped<double?>? averageReview,
      Wrapped<List<GetStoreCategory>?>? categories,
      Wrapped<String?>? description,
      Wrapped<String?>? googleMapsLink,
      Wrapped<String?>? id,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? name,
      Wrapped<List<GetStoreOpeningHour>?>? openingHours,
      Wrapped<String?>? phoneNumber,
      Wrapped<int?>? reviewCount}) {
    return GetStoreResponse(
        address: (address != null ? address.value : this.address),
        averagePickupTime: (averagePickupTime != null
            ? averagePickupTime.value
            : this.averagePickupTime),
        averageReview:
            (averageReview != null ? averageReview.value : this.averageReview),
        categories: (categories != null ? categories.value : this.categories),
        description:
            (description != null ? description.value : this.description),
        googleMapsLink: (googleMapsLink != null
            ? googleMapsLink.value
            : this.googleMapsLink),
        id: (id != null ? id.value : this.id),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        name: (name != null ? name.value : this.name),
        openingHours:
            (openingHours != null ? openingHours.value : this.openingHours),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
        reviewCount:
            (reviewCount != null ? reviewCount.value : this.reviewCount));
  }
}

@JsonSerializable(explicitToJson: true)
class GetStoresOverviewResponse {
  GetStoresOverviewResponse({
    this.address,
    this.averagePickupTime,
    this.averageReview,
    this.description,
    this.googleMapsLink,
    this.id,
    this.imageUrl,
    this.isAvailable,
    this.name,
    this.phoneNumber,
    this.reviewCount,
  });

  factory GetStoresOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$GetStoresOverviewResponseFromJson(json);

  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'averagePickupTime', includeIfNull: false)
  final int? averagePickupTime;
  @JsonKey(name: 'averageReview', includeIfNull: false)
  final double? averageReview;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'googleMapsLink', includeIfNull: false)
  final String? googleMapsLink;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'isAvailable', includeIfNull: false)
  final bool? isAvailable;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'reviewCount', includeIfNull: false)
  final int? reviewCount;
  static const fromJsonFactory = _$GetStoresOverviewResponseFromJson;
  static const toJsonFactory = _$GetStoresOverviewResponseToJson;
  Map<String, dynamic> toJson() => _$GetStoresOverviewResponseToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetStoresOverviewResponse &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.averagePickupTime, averagePickupTime) ||
                const DeepCollectionEquality()
                    .equals(other.averagePickupTime, averagePickupTime)) &&
            (identical(other.averageReview, averageReview) ||
                const DeepCollectionEquality()
                    .equals(other.averageReview, averageReview)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.googleMapsLink, googleMapsLink) ||
                const DeepCollectionEquality()
                    .equals(other.googleMapsLink, googleMapsLink)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.isAvailable, isAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isAvailable, isAvailable)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.reviewCount, reviewCount) ||
                const DeepCollectionEquality()
                    .equals(other.reviewCount, reviewCount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(averagePickupTime) ^
      const DeepCollectionEquality().hash(averageReview) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(googleMapsLink) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(isAvailable) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(reviewCount) ^
      runtimeType.hashCode;
}

extension $GetStoresOverviewResponseExtension on GetStoresOverviewResponse {
  GetStoresOverviewResponse copyWith(
      {String? address,
      int? averagePickupTime,
      double? averageReview,
      String? description,
      String? googleMapsLink,
      String? id,
      String? imageUrl,
      bool? isAvailable,
      String? name,
      String? phoneNumber,
      int? reviewCount}) {
    return GetStoresOverviewResponse(
        address: address ?? this.address,
        averagePickupTime: averagePickupTime ?? this.averagePickupTime,
        averageReview: averageReview ?? this.averageReview,
        description: description ?? this.description,
        googleMapsLink: googleMapsLink ?? this.googleMapsLink,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        isAvailable: isAvailable ?? this.isAvailable,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        reviewCount: reviewCount ?? this.reviewCount);
  }

  GetStoresOverviewResponse copyWithWrapped(
      {Wrapped<String?>? address,
      Wrapped<int?>? averagePickupTime,
      Wrapped<double?>? averageReview,
      Wrapped<String?>? description,
      Wrapped<String?>? googleMapsLink,
      Wrapped<String?>? id,
      Wrapped<String?>? imageUrl,
      Wrapped<bool?>? isAvailable,
      Wrapped<String?>? name,
      Wrapped<String?>? phoneNumber,
      Wrapped<int?>? reviewCount}) {
    return GetStoresOverviewResponse(
        address: (address != null ? address.value : this.address),
        averagePickupTime: (averagePickupTime != null
            ? averagePickupTime.value
            : this.averagePickupTime),
        averageReview:
            (averageReview != null ? averageReview.value : this.averageReview),
        description:
            (description != null ? description.value : this.description),
        googleMapsLink: (googleMapsLink != null
            ? googleMapsLink.value
            : this.googleMapsLink),
        id: (id != null ? id.value : this.id),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        isAvailable:
            (isAvailable != null ? isAvailable.value : this.isAvailable),
        name: (name != null ? name.value : this.name),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
        reviewCount:
            (reviewCount != null ? reviewCount.value : this.reviewCount));
  }
}

@JsonSerializable(explicitToJson: true)
class Menu {
  Menu({
    this.categories,
    this.openingHours,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  @JsonKey(
      name: 'categories',
      includeIfNull: false,
      defaultValue: <GetStoreCategory>[])
  final List<GetStoreCategory>? categories;
  @JsonKey(
      name: 'opening_hours',
      includeIfNull: false,
      defaultValue: <GetStoreOpeningHour>[])
  final List<GetStoreOpeningHour>? openingHours;
  static const fromJsonFactory = _$MenuFromJson;
  static const toJsonFactory = _$MenuToJson;
  Map<String, dynamic> toJson() => _$MenuToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Menu &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.openingHours, openingHours) ||
                const DeepCollectionEquality()
                    .equals(other.openingHours, openingHours)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(openingHours) ^
      runtimeType.hashCode;
}

extension $MenuExtension on Menu {
  Menu copyWith(
      {List<GetStoreCategory>? categories,
      List<GetStoreOpeningHour>? openingHours}) {
    return Menu(
        categories: categories ?? this.categories,
        openingHours: openingHours ?? this.openingHours);
  }

  Menu copyWithWrapped(
      {Wrapped<List<GetStoreCategory>?>? categories,
      Wrapped<List<GetStoreOpeningHour>?>? openingHours}) {
    return Menu(
        categories: (categories != null ? categories.value : this.categories),
        openingHours:
            (openingHours != null ? openingHours.value : this.openingHours));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  OrderItem({
    this.id,
    this.name,
    this.plu,
    this.price,
    this.quantity,
    this.subItems,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'plu', includeIfNull: false)
  final String? plu;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'quantity', includeIfNull: false)
  final int? quantity;
  @JsonKey(name: 'subItems', includeIfNull: false, defaultValue: <OrderItem>[])
  final List<OrderItem>? subItems;
  static const fromJsonFactory = _$OrderItemFromJson;
  static const toJsonFactory = _$OrderItemToJson;
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.plu, plu) ||
                const DeepCollectionEquality().equals(other.plu, plu)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.subItems, subItems) ||
                const DeepCollectionEquality()
                    .equals(other.subItems, subItems)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(plu) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(subItems) ^
      runtimeType.hashCode;
}

extension $OrderItemExtension on OrderItem {
  OrderItem copyWith(
      {String? id,
      String? name,
      String? plu,
      int? price,
      int? quantity,
      List<OrderItem>? subItems}) {
    return OrderItem(
        id: id ?? this.id,
        name: name ?? this.name,
        plu: plu ?? this.plu,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        subItems: subItems ?? this.subItems);
  }

  OrderItem copyWithWrapped(
      {Wrapped<String?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? plu,
      Wrapped<int?>? price,
      Wrapped<int?>? quantity,
      Wrapped<List<OrderItem>?>? subItems}) {
    return OrderItem(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        plu: (plu != null ? plu.value : this.plu),
        price: (price != null ? price.value : this.price),
        quantity: (quantity != null ? quantity.value : this.quantity),
        subItems: (subItems != null ? subItems.value : this.subItems));
  }
}

@JsonSerializable(explicitToJson: true)
class User {
  User({
    this.createdAt,
    this.firebaseId,
    this.firstname,
    this.id,
    this.languageCode,
    this.lastname,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'firebaseId', includeIfNull: false)
  final String? firebaseId;
  @JsonKey(name: 'firstname', includeIfNull: false)
  final String? firstname;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'languageCode', includeIfNull: false)
  final String? languageCode;
  @JsonKey(name: 'lastname', includeIfNull: false)
  final String? lastname;
  static const fromJsonFactory = _$UserFromJson;
  static const toJsonFactory = _$UserToJson;
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is User &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.firebaseId, firebaseId) ||
                const DeepCollectionEquality()
                    .equals(other.firebaseId, firebaseId)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.languageCode, languageCode) ||
                const DeepCollectionEquality()
                    .equals(other.languageCode, languageCode)) &&
            (identical(other.lastname, lastname) ||
                const DeepCollectionEquality()
                    .equals(other.lastname, lastname)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(firebaseId) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(languageCode) ^
      const DeepCollectionEquality().hash(lastname) ^
      runtimeType.hashCode;
}

extension $UserExtension on User {
  User copyWith(
      {String? createdAt,
      String? firebaseId,
      String? firstname,
      String? id,
      String? languageCode,
      String? lastname}) {
    return User(
        createdAt: createdAt ?? this.createdAt,
        firebaseId: firebaseId ?? this.firebaseId,
        firstname: firstname ?? this.firstname,
        id: id ?? this.id,
        languageCode: languageCode ?? this.languageCode,
        lastname: lastname ?? this.lastname);
  }

  User copyWithWrapped(
      {Wrapped<String?>? createdAt,
      Wrapped<String?>? firebaseId,
      Wrapped<String?>? firstname,
      Wrapped<String?>? id,
      Wrapped<String?>? languageCode,
      Wrapped<String?>? lastname}) {
    return User(
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        firebaseId: (firebaseId != null ? firebaseId.value : this.firebaseId),
        firstname: (firstname != null ? firstname.value : this.firstname),
        id: (id != null ? id.value : this.id),
        languageCode:
            (languageCode != null ? languageCode.value : this.languageCode),
        lastname: (lastname != null ? lastname.value : this.lastname));
  }
}

@JsonSerializable(explicitToJson: true)
class WhitelistRequest {
  WhitelistRequest({
    required this.identifier,
  });

  factory WhitelistRequest.fromJson(Map<String, dynamic> json) =>
      _$WhitelistRequestFromJson(json);

  @JsonKey(name: 'identifier', includeIfNull: false)
  final String identifier;
  static const fromJsonFactory = _$WhitelistRequestFromJson;
  static const toJsonFactory = _$WhitelistRequestToJson;
  Map<String, dynamic> toJson() => _$WhitelistRequestToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WhitelistRequest &&
            (identical(other.identifier, identifier) ||
                const DeepCollectionEquality()
                    .equals(other.identifier, identifier)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(identifier) ^ runtimeType.hashCode;
}

extension $WhitelistRequestExtension on WhitelistRequest {
  WhitelistRequest copyWith({String? identifier}) {
    return WhitelistRequest(identifier: identifier ?? this.identifier);
  }

  WhitelistRequest copyWithWrapped({Wrapped<String>? identifier}) {
    return WhitelistRequest(
        identifier: (identifier != null ? identifier.value : this.identifier));
  }
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
