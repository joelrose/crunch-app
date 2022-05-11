// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRelationModelDto _$CategoryRelationModelDtoFromJson(
        Map<String, dynamic> json) =>
    CategoryRelationModelDto(
      product: json['product'] == null
          ? null
          : DeliverectProductModelDto.fromJson(
              json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryRelationModelDtoToJson(
    CategoryRelationModelDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('product', instance.product?.toJson());
  return val;
}

CreateOrderItemDto _$CreateOrderItemDtoFromJson(Map<String, dynamic> json) =>
    CreateOrderItemDto(
      plu: json['plu'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => CreateOrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateOrderItemDtoToJson(CreateOrderItemDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('plu', instance.plu);
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}

CreateOrderRequestDto _$CreateOrderRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateOrderRequestDto(
      merchantId: json['merchantId'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => CreateOrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateOrderRequestDtoToJson(
    CreateOrderRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('merchantId', instance.merchantId);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}

CreateOrderResponseDto _$CreateOrderResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CreateOrderResponseDto(
      clientSecret: json['clientSecret'] as String?,
    );

Map<String, dynamic> _$CreateOrderResponseDtoToJson(
    CreateOrderResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('clientSecret', instance.clientSecret);
  return val;
}

CreateUserRequestDto _$CreateUserRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateUserRequestDto(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      languageCode: json['languageCode'] as String?,
    );

Map<String, dynamic> _$CreateUserRequestDtoToJson(
    CreateUserRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('languageCode', instance.languageCode);
  return val;
}

DeliverectAvailabilityModel _$DeliverectAvailabilityModelFromJson(
        Map<String, dynamic> json) =>
    DeliverectAvailabilityModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),

      // FIXED MANUALLY
      dayOfWeek: deliverectDayFromJson((json['dayOfWeek'] as int).toString()),
      endTime: json['endTime'] as String?,
      startTime: json['startTime'] as String?,
    );

Map<String, dynamic> _$DeliverectAvailabilityModelToJson(
    DeliverectAvailabilityModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('dayOfWeek', deliverectDayToJson(instance.dayOfWeek));
  writeNotNull('endTime', instance.endTime);
  writeNotNull('startTime', instance.startTime);
  return val;
}

DeliverectCategoryModelDto _$DeliverectCategoryModelDtoFromJson(
        Map<String, dynamic> json) =>
    DeliverectCategoryModelDto(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      categoryId: json['categoryId'] as String?,
      account: json['account'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: json['level'] as int?,
      menu: json['menu'] as String?,
      name: json['name'] as String?,
      sortOrder: json['sortOrder'] as int?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) =>
                  CategoryRelationModelDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DeliverectCategoryModelDtoToJson(
    DeliverectCategoryModelDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('account', instance.account);
  writeNotNull('description', instance.description);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('level', instance.level);
  writeNotNull('menu', instance.menu);
  writeNotNull('name', instance.name);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  return val;
}

DeliverectMenuDto _$DeliverectMenuDtoFromJson(Map<String, dynamic> json) =>
    DeliverectMenuDto(
      availabilities: (json['availabilities'] as List<dynamic>?)
              ?.map((e) => DeliverectAvailabilityModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => DeliverectCategoryModelDto.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      channelLinkId: json['channelLinkId'] as String?,
      currency: json['currency'] as int?,
      description: json['description'] as String?,
      menu: json['menu'] as String?,
      menuId: json['menuId'] as String?,
      menuImageUrl: json['menuImageUrl'] as String?,
      menuType: json['menuType'] as int?,
    );

Map<String, dynamic> _$DeliverectMenuDtoToJson(DeliverectMenuDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('availabilities',
      instance.availabilities?.map((e) => e.toJson()).toList());
  writeNotNull(
      'categories', instance.categories?.map((e) => e.toJson()).toList());
  writeNotNull('channelLinkId', instance.channelLinkId);
  writeNotNull('currency', instance.currency);
  writeNotNull('description', instance.description);
  writeNotNull('menu', instance.menu);
  writeNotNull('menuId', instance.menuId);
  writeNotNull('menuImageUrl', instance.menuImageUrl);
  writeNotNull('menuType', instance.menuType);
  return val;
}

DeliverectMenusDto _$DeliverectMenusDtoFromJson(Map<String, dynamic> json) =>
    DeliverectMenusDto(
      availabilities: (json['availabilities'] as List<dynamic>?)
              ?.map((e) => DeliverectAvailabilityModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'] as String?,
      menu: json['menu'] as String?,
      menuId: json['menuId'] as String?,
      menuImageUrl: json['menuImageUrl'] as String?,
      menuType: json['menuType'] as int?,
    );

Map<String, dynamic> _$DeliverectMenusDtoToJson(DeliverectMenusDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('availabilities',
      instance.availabilities?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description);
  writeNotNull('menu', instance.menu);
  writeNotNull('menuId', instance.menuId);
  writeNotNull('menuImageUrl', instance.menuImageUrl);
  writeNotNull('menuType', instance.menuType);
  return val;
}

DeliverectProductModelDto _$DeliverectProductModelDtoFromJson(
        Map<String, dynamic> json) =>
    DeliverectProductModelDto(
      productId: json['productId'] as String?,
      account: json['account'] as String?,
      deliveryTax: json['deliveryTax'] as int?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String?,
      max: json['max'] as int?,
      min: json['min'] as int?,
      multiply: json['multiply'] as int?,
      multiMax: json['multiMax'] as int?,
      name: json['name'] as String?,
      plu: json['plu'] as String?,
      price: json['price'] as int?,
      productType: json['productType'] as int?,
      snoozed: json['snoozed'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      takeawayTax: json['takeawayTax'] as int?,
      visible: json['visible'] as bool?,
      childProducts: (json['childProducts'] as List<dynamic>?)
              ?.map((e) =>
                  ProductRelationModelDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DeliverectProductModelDtoToJson(
    DeliverectProductModelDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productId', instance.productId);
  writeNotNull('account', instance.account);
  writeNotNull('deliveryTax', instance.deliveryTax);
  writeNotNull('description', instance.description);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('location', instance.location);
  writeNotNull('max', instance.max);
  writeNotNull('min', instance.min);
  writeNotNull('multiply', instance.multiply);
  writeNotNull('multiMax', instance.multiMax);
  writeNotNull('name', instance.name);
  writeNotNull('plu', instance.plu);
  writeNotNull('price', instance.price);
  writeNotNull('productType', instance.productType);
  writeNotNull('snoozed', instance.snoozed);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('takeawayTax', instance.takeawayTax);
  writeNotNull('visible', instance.visible);
  writeNotNull(
      'childProducts', instance.childProducts?.map((e) => e.toJson()).toList());
  return val;
}

GetMenuResponseDto _$GetMenuResponseDtoFromJson(Map<String, dynamic> json) =>
    GetMenuResponseDto(
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as String?,
      averagePickUpTime: json['averagePickUpTime'] as String?,
      address: json['address'] as String?,
      googleMapsLink: json['googleMapsLink'] as String?,
      menu: json['menu'] == null
          ? null
          : DeliverectMenuDto.fromJson(json['menu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMenuResponseDtoToJson(GetMenuResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewCount', instance.reviewCount);
  writeNotNull('averagePickUpTime', instance.averagePickUpTime);
  writeNotNull('address', instance.address);
  writeNotNull('googleMapsLink', instance.googleMapsLink);
  writeNotNull('menu', instance.menu?.toJson());
  return val;
}

GetMenusResponseDto _$GetMenusResponseDtoFromJson(Map<String, dynamic> json) =>
    GetMenusResponseDto(
      id: json['id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as String?,
      averagePickUpTime: json['averagePickUpTime'] as String?,
      menu: json['menu'] == null
          ? null
          : DeliverectMenusDto.fromJson(json['menu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMenusResponseDtoToJson(GetMenusResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewCount', instance.reviewCount);
  writeNotNull('averagePickUpTime', instance.averagePickUpTime);
  writeNotNull('menu', instance.menu?.toJson());
  return val;
}

GetOrderResponseDto _$GetOrderResponseDtoFromJson(Map<String, dynamic> json) =>
    GetOrderResponseDto(
      id: json['id'] as String?,
      // TODO: manually edited
      status: deliverectOrderStatusFromJson((json['status'] as int).toString()),
      price: (json['price'] as num?)?.toDouble(),
      estimatedPickUpTime: json['estimatedPickUpTime'] == null
          ? null
          : DateTime.parse(json['estimatedPickUpTime'] as String),
      merchant: json['merchant'] == null
          ? null
          : MerchantModelDto.fromJson(json['merchant'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetOrderResponseDtoToJson(GetOrderResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', deliverectOrderStatusToJson(instance.status));
  writeNotNull('price', instance.price);
  writeNotNull(
      'estimatedPickUpTime', instance.estimatedPickUpTime?.toIso8601String());
  writeNotNull('merchant', instance.merchant?.toJson());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}

GetUserResponseDto _$GetUserResponseDtoFromJson(Map<String, dynamic> json) =>
    GetUserResponseDto(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$GetUserResponseDtoToJson(GetUserResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  return val;
}

MerchantModelDto _$MerchantModelDtoFromJson(Map<String, dynamic> json) =>
    MerchantModelDto(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as String?,
      averagePickUpTime: json['averagePickUpTime'] as String?,
      address: json['address'] as String?,
      googleMapsLink: json['googleMapsLink'] as String?,
    );

Map<String, dynamic> _$MerchantModelDtoToJson(MerchantModelDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewCount', instance.reviewCount);
  writeNotNull('averagePickUpTime', instance.averagePickUpTime);
  writeNotNull('address', instance.address);
  writeNotNull('googleMapsLink', instance.googleMapsLink);
  return val;
}

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      plu: json['plu'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      parent: json['parent'] == null
          ? null
          : OrderItemModel.fromJson(json['parent'] as Map<String, dynamic>),
      parentId: json['parentId'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('plu', instance.plu);
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('parent', instance.parent?.toJson());
  writeNotNull('parentId', instance.parentId);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}

ProductRelationModelDto _$ProductRelationModelDtoFromJson(
        Map<String, dynamic> json) =>
    ProductRelationModelDto(
      childProduct: json['childProduct'] == null
          ? null
          : DeliverectProductModelDto.fromJson(
              json['childProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductRelationModelDtoToJson(
    ProductRelationModelDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('childProduct', instance.childProduct?.toJson());
  return val;
}

UpdateStatusOrderModel _$UpdateStatusOrderModelFromJson(
        Map<String, dynamic> json) =>
    UpdateStatusOrderModel(
      orderId: json['orderId'] as String?,
      orderStatus:
          deliverectOrderStatusFromJson(json['orderStatus'] as String?),
    );

Map<String, dynamic> _$UpdateStatusOrderModelToJson(
    UpdateStatusOrderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('orderId', instance.orderId);
  writeNotNull(
      'orderStatus', deliverectOrderStatusToJson(instance.orderStatus));
  return val;
}
