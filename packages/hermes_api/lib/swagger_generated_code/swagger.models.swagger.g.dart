// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(
      orderItems: (json['orderItems'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'orderItems', instance.orderItems?.map((e) => e.toJson()).toList());
  writeNotNull('storeId', instance.storeId);
  return val;
}

CreateOrderResponse _$CreateOrderResponseFromJson(Map<String, dynamic> json) =>
    CreateOrderResponse(
      stripeClientSecret: json['stripeClientSecret'] as String?,
    );

Map<String, dynamic> _$CreateOrderResponseToJson(CreateOrderResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stripeClientSecret', instance.stripeClientSecret);
  return val;
}

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      firstname: json['firstname'] as String?,
      languageCode: json['language_code'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstname', instance.firstname);
  writeNotNull('language_code', instance.languageCode);
  writeNotNull('lastname', instance.lastname);
  return val;
}

GetOrdersResponse _$GetOrdersResponseFromJson(Map<String, dynamic> json) =>
    GetOrdersResponse(
      createdAt: json['createdAt'] as String?,
      estimatedPickupTime: json['estimatedPickupTime'] as String?,
      googleMapsLink: json['googleMapsLink'] as String?,
      id: json['id'] as int?,
      isPaid: json['isPaid'] as bool?,
      orderItems: (json['orderItems'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      price: json['price'] as int?,
      status: json['status'] as int?,
      storeAddress: json['storeAddress'] as String?,
      storeDescription: json['storeDescription'] as String?,
      storeImageUrl: json['storeImageUrl'] as String?,
      storeName: json['storeName'] as String?,
      storePhoneNumber: json['storePhoneNumber'] as String?,
    );

Map<String, dynamic> _$GetOrdersResponseToJson(GetOrdersResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('estimatedPickupTime', instance.estimatedPickupTime);
  writeNotNull('googleMapsLink', instance.googleMapsLink);
  writeNotNull('id', instance.id);
  writeNotNull('isPaid', instance.isPaid);
  writeNotNull(
      'orderItems', instance.orderItems?.map((e) => e.toJson()).toList());
  writeNotNull('price', instance.price);
  writeNotNull('status', instance.status);
  writeNotNull('storeAddress', instance.storeAddress);
  writeNotNull('storeDescription', instance.storeDescription);
  writeNotNull('storeImageUrl', instance.storeImageUrl);
  writeNotNull('storeName', instance.storeName);
  writeNotNull('storePhoneNumber', instance.storePhoneNumber);
  return val;
}

GetStoreCategory _$GetStoreCategoryFromJson(Map<String, dynamic> json) =>
    GetStoreCategory(
      description: json['description'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => GetStoreProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$GetStoreCategoryToJson(GetStoreCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('id', instance.id);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('name', instance.name);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  writeNotNull('sortOrder', instance.sortOrder);
  return val;
}

GetStoreOpeningHour _$GetStoreOpeningHourFromJson(Map<String, dynamic> json) =>
    GetStoreOpeningHour(
      dayOfWeek: json['dayOfWeek'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      startTimestamp: json['startTimestamp'] as int?,
    );

Map<String, dynamic> _$GetStoreOpeningHourToJson(GetStoreOpeningHour instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dayOfWeek', instance.dayOfWeek);
  writeNotNull('endTimestamp', instance.endTimestamp);
  writeNotNull('startTimestamp', instance.startTimestamp);
  return val;
}

GetStoreProduct _$GetStoreProductFromJson(Map<String, dynamic> json) =>
    GetStoreProduct(
      description: json['description'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      max: json['max'] as int?,
      min: json['min'] as int?,
      multiMax: json['multiMax'] as int?,
      multiply: json['multiply'] as int?,
      name: json['name'] as String?,
      plu: json['plu'] as String?,
      price: json['price'] as int?,
      productType: json['productType'] as int?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => GetStoreProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      snoozed: json['snoozed'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      tax: json['tax'] as int?,
      visible: json['visible'] as bool?,
    );

Map<String, dynamic> _$GetStoreProductToJson(GetStoreProduct instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('id', instance.id);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('max', instance.max);
  writeNotNull('min', instance.min);
  writeNotNull('multiMax', instance.multiMax);
  writeNotNull('multiply', instance.multiply);
  writeNotNull('name', instance.name);
  writeNotNull('plu', instance.plu);
  writeNotNull('price', instance.price);
  writeNotNull('productType', instance.productType);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  writeNotNull('snoozed', instance.snoozed);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('tax', instance.tax);
  writeNotNull('visible', instance.visible);
  return val;
}

GetStoreResponse _$GetStoreResponseFromJson(Map<String, dynamic> json) =>
    GetStoreResponse(
      address: json['address'] as String?,
      averagePickupTime: json['averagePickupTime'] as int?,
      averageReview: (json['averageReview'] as num?)?.toDouble(),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => GetStoreCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String?,
      googleMapsLink: json['googleMapsLink'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      openingHours: (json['openingHours'] as List<dynamic>?)
              ?.map((e) =>
                  GetStoreOpeningHour.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      phoneNumber: json['phoneNumber'] as String?,
      reviewCount: json['reviewCount'] as int?,
    );

Map<String, dynamic> _$GetStoreResponseToJson(GetStoreResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  writeNotNull('averagePickupTime', instance.averagePickupTime);
  writeNotNull('averageReview', instance.averageReview);
  writeNotNull(
      'categories', instance.categories?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description);
  writeNotNull('googleMapsLink', instance.googleMapsLink);
  writeNotNull('id', instance.id);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('name', instance.name);
  writeNotNull(
      'openingHours', instance.openingHours?.map((e) => e.toJson()).toList());
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('reviewCount', instance.reviewCount);
  return val;
}

GetStoresOverviewResponse _$GetStoresOverviewResponseFromJson(
        Map<String, dynamic> json) =>
    GetStoresOverviewResponse(
      address: json['address'] as String?,
      averagePickupTime: json['averagePickupTime'] as int?,
      averageReview: (json['averageReview'] as num?)?.toDouble(),
      description: json['description'] as String?,
      googleMapsLink: json['googleMapsLink'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      reviewCount: json['reviewCount'] as int?,
    );

Map<String, dynamic> _$GetStoresOverviewResponseToJson(
    GetStoresOverviewResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  writeNotNull('averagePickupTime', instance.averagePickupTime);
  writeNotNull('averageReview', instance.averageReview);
  writeNotNull('description', instance.description);
  writeNotNull('googleMapsLink', instance.googleMapsLink);
  writeNotNull('id', instance.id);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('isAvailable', instance.isAvailable);
  writeNotNull('name', instance.name);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('reviewCount', instance.reviewCount);
  return val;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      plu: json['plu'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      subItems: (json['subItems'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('plu', instance.plu);
  writeNotNull('price', instance.price);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('subItems', instance.subItems?.map((e) => e.toJson()).toList());
  return val;
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      createdAt: json['createdAt'] as String?,
      firebaseId: json['firebaseId'] as String?,
      firstname: json['firstname'] as String?,
      id: json['id'] as int?,
      languageCode: json['languageCode'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('firebaseId', instance.firebaseId);
  writeNotNull('firstname', instance.firstname);
  writeNotNull('id', instance.id);
  writeNotNull('languageCode', instance.languageCode);
  writeNotNull('lastname', instance.lastname);
  return val;
}

WhitelistRequest _$WhitelistRequestFromJson(Map<String, dynamic> json) =>
    WhitelistRequest(
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$WhitelistRequestToJson(WhitelistRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('identifier', instance.identifier);
  return val;
}

MenusMenuRedisModel _$MenusMenuRedisModelFromJson(Map<String, dynamic> json) =>
    MenusMenuRedisModel(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => GetStoreCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      openingHours: (json['openingHours'] as List<dynamic>?)
              ?.map((e) =>
                  GetStoreOpeningHour.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MenusMenuRedisModelToJson(MenusMenuRedisModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'categories', instance.categories?.map((e) => e.toJson()).toList());
  writeNotNull(
      'openingHours', instance.openingHours?.map((e) => e.toJson()).toList());
  return val;
}
