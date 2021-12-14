// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderItemDto _$CreateOrderItemDtoFromJson(Map<String, dynamic> json) =>
    CreateOrderItemDto(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CreateOrderItemDtoToJson(CreateOrderItemDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('comment', instance.comment);
  return val;
}

CreateOrderRequestDto _$CreateOrderRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateOrderRequestDto(
      storeId: json['storeId'] as String?,
      price: (json['price'] as num?)?.toDouble(),
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

  writeNotNull('storeId', instance.storeId);
  writeNotNull('price', instance.price);
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

CreateTokenRequestDto _$CreateTokenRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateTokenRequestDto(
      fcmToken: json['fcmToken'] as String?,
      device: tokenDeviceFromJson(json['device'] as String?),
    );

Map<String, dynamic> _$CreateTokenRequestDtoToJson(
    CreateTokenRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fcmToken', instance.fcmToken);
  writeNotNull('device', tokenDeviceToJson(instance.device));
  return val;
}

CreateUserRequestDto _$CreateUserRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateUserRequestDto(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
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
  return val;
}

GetOrderResponseDto _$GetOrderResponseDtoFromJson(Map<String, dynamic> json) =>
    GetOrderResponseDto(
      id: json['id'] as String?,
      storeId: json['storeId'] as String?,
      status: orderStatusFromJson(json['status'] as String?),
      price: (json['price'] as num?)?.toDouble(),
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
  writeNotNull('storeId', instance.storeId);
  writeNotNull('status', orderStatusToJson(instance.status));
  writeNotNull('price', instance.price);
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

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      comment: json['comment'] as String?,
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
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('comment', instance.comment);
  return val;
}

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      fcmToken: json['fcmToken'] as String?,
      device: tokenDeviceFromJson(json['device'] as String?),
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('fcmToken', instance.fcmToken);
  writeNotNull('device', tokenDeviceToJson(instance.device));
  return val;
}

UpdateStatusOrderModel _$UpdateStatusOrderModelFromJson(
        Map<String, dynamic> json) =>
    UpdateStatusOrderModel(
      orderId: json['orderId'] as String?,
      orderStatus: orderStatusFromJson(json['orderStatus'] as String?),
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
  writeNotNull('orderStatus', orderStatusToJson(instance.orderStatus));
  return val;
}
