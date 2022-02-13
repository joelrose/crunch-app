import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'swagger.enums.swagger.dart' as enums;
export 'swagger.enums.swagger.dart';

part 'swagger.swagger.chopper.dart';
part 'swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create([ChopperClient? client]) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
        services: [_$Swagger()],
        converter: $JsonSerializableConverter(),
        baseUrl: 'https://');
    return _$Swagger(newClient);
  }

  ///
  @Post(path: '/api/orders')
  Future<chopper.Response<CreateOrderResponseDto>> apiOrdersPost(
      {@Body() required CreateOrderRequestDto? body});

  ///
  @Put(path: '/api/orders')
  Future<chopper.Response<bool>> apiOrdersPut(
      {@Body() required UpdateStatusOrderModel? body});

  ///
  @Get(path: '/api/orders')
  Future<chopper.Response<List<GetOrderResponseDto>>> apiOrdersGet();

  ///
  ///@param orderId
  @Get(path: '/api/orders/{orderId}')
  Future<chopper.Response<GetOrderResponseDto>> apiOrdersOrderIdGet(
      {@Path('orderId') required String? orderId});

  ///
  @Post(path: '/webhook/stripe', optionalBody: true)
  Future<chopper.Response<bool>> webhookStripePost();

  ///
  @Post(path: '/api/tokens')
  Future<chopper.Response<bool>> apiTokensPost(
      {@Body() required CreateTokenRequestDto? body});

  ///
  @Delete(path: '/api/tokens')
  Future<chopper.Response<bool>> apiTokensDelete(
      {@Body() required String? body});

  ///
  @Get(path: '/api/tokens')
  Future<chopper.Response<List<TokenModel>>> apiTokensGet();

  ///
  @Post(path: '/api/users')
  Future<chopper.Response<bool>> apiUsersPost(
      {@Body() required CreateUserRequestDto? body});

  ///
  @Delete(path: '/api/users')
  Future<chopper.Response<bool>> apiUsersDelete();

  ///
  @Get(path: '/api/users')
  Future<chopper.Response<GetUserResponseDto>> apiUsersGet();
}

final Map<Type, Object Function(Map<String, dynamic>)>
    SwaggerJsonDecoderMappings = {
  CreateOrderItemDto: CreateOrderItemDto.fromJsonFactory,
  CreateOrderRequestDto: CreateOrderRequestDto.fromJsonFactory,
  CreateOrderResponseDto: CreateOrderResponseDto.fromJsonFactory,
  CreateTokenRequestDto: CreateTokenRequestDto.fromJsonFactory,
  CreateUserRequestDto: CreateUserRequestDto.fromJsonFactory,
  GetOrderResponseDto: GetOrderResponseDto.fromJsonFactory,
  GetUserResponseDto: GetUserResponseDto.fromJsonFactory,
  OrderItemModel: OrderItemModel.fromJsonFactory,
  TokenModel: TokenModel.fromJsonFactory,
  UpdateStatusOrderModel: UpdateStatusOrderModel.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class CreateOrderItemDto {
  CreateOrderItemDto({
    this.name,
    this.price,
    this.comment,
  });

  factory CreateOrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderItemDtoFromJson(json);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'comment', includeIfNull: false)
  final String? comment;
  static const fromJsonFactory = _$CreateOrderItemDtoFromJson;
  static const toJsonFactory = _$CreateOrderItemDtoToJson;
  Map<String, dynamic> toJson() => _$CreateOrderItemDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderItemDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality().equals(other.comment, comment)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(comment) ^
      runtimeType.hashCode;
}

extension $CreateOrderItemDtoExtension on CreateOrderItemDto {
  CreateOrderItemDto copyWith({String? name, double? price, String? comment}) {
    return CreateOrderItemDto(
        name: name ?? this.name,
        price: price ?? this.price,
        comment: comment ?? this.comment);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderRequestDto {
  CreateOrderRequestDto({
    this.storeId,
    this.price,
    this.items,
    this.stripeOrderId,
  });

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);

  @JsonKey(name: 'storeId', includeIfNull: false)
  final String? storeId;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(
      name: 'items', includeIfNull: false, defaultValue: <CreateOrderItemDto>[])
  final List<CreateOrderItemDto>? items;
  @JsonKey(name: 'stripeOrderId', includeIfNull: false)
  final String? stripeOrderId;
  static const fromJsonFactory = _$CreateOrderRequestDtoFromJson;
  static const toJsonFactory = _$CreateOrderRequestDtoToJson;
  Map<String, dynamic> toJson() => _$CreateOrderRequestDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderRequestDto &&
            (identical(other.storeId, storeId) ||
                const DeepCollectionEquality()
                    .equals(other.storeId, storeId)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.stripeOrderId, stripeOrderId) ||
                const DeepCollectionEquality()
                    .equals(other.stripeOrderId, stripeOrderId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(storeId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(stripeOrderId) ^
      runtimeType.hashCode;
}

extension $CreateOrderRequestDtoExtension on CreateOrderRequestDto {
  CreateOrderRequestDto copyWith(
      {String? storeId,
      double? price,
      List<CreateOrderItemDto>? items,
      String? stripeOrderId}) {
    return CreateOrderRequestDto(
        storeId: storeId ?? this.storeId,
        price: price ?? this.price,
        items: items ?? this.items,
        stripeOrderId: stripeOrderId ?? this.stripeOrderId);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderResponseDto {
  CreateOrderResponseDto({
    this.clientSecret,
  });

  factory CreateOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseDtoFromJson(json);

  @JsonKey(name: 'clientSecret', includeIfNull: false)
  final String? clientSecret;
  static const fromJsonFactory = _$CreateOrderResponseDtoFromJson;
  static const toJsonFactory = _$CreateOrderResponseDtoToJson;
  Map<String, dynamic> toJson() => _$CreateOrderResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderResponseDto &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.clientSecret, clientSecret)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(clientSecret) ^ runtimeType.hashCode;
}

extension $CreateOrderResponseDtoExtension on CreateOrderResponseDto {
  CreateOrderResponseDto copyWith({String? clientSecret}) {
    return CreateOrderResponseDto(
        clientSecret: clientSecret ?? this.clientSecret);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateTokenRequestDto {
  CreateTokenRequestDto({
    this.playerId,
    this.device,
  });

  factory CreateTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTokenRequestDtoFromJson(json);

  @JsonKey(name: 'playerId', includeIfNull: false)
  final String? playerId;
  @JsonKey(
      name: 'device',
      includeIfNull: false,
      toJson: tokenDeviceToJson,
      fromJson: tokenDeviceFromJson)
  final enums.TokenDevice? device;
  static const fromJsonFactory = _$CreateTokenRequestDtoFromJson;
  static const toJsonFactory = _$CreateTokenRequestDtoToJson;
  Map<String, dynamic> toJson() => _$CreateTokenRequestDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateTokenRequestDto &&
            (identical(other.playerId, playerId) ||
                const DeepCollectionEquality()
                    .equals(other.playerId, playerId)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(playerId) ^
      const DeepCollectionEquality().hash(device) ^
      runtimeType.hashCode;
}

extension $CreateTokenRequestDtoExtension on CreateTokenRequestDto {
  CreateTokenRequestDto copyWith(
      {String? playerId, enums.TokenDevice? device}) {
    return CreateTokenRequestDto(
        playerId: playerId ?? this.playerId, device: device ?? this.device);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateUserRequestDto {
  CreateUserRequestDto({
    this.firstName,
    this.lastName,
  });

  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);

  @JsonKey(name: 'firstName', includeIfNull: false)
  final String? firstName;
  @JsonKey(name: 'lastName', includeIfNull: false)
  final String? lastName;
  static const fromJsonFactory = _$CreateUserRequestDtoFromJson;
  static const toJsonFactory = _$CreateUserRequestDtoToJson;
  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateUserRequestDto &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      runtimeType.hashCode;
}

extension $CreateUserRequestDtoExtension on CreateUserRequestDto {
  CreateUserRequestDto copyWith({String? firstName, String? lastName}) {
    return CreateUserRequestDto(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName);
  }
}

@JsonSerializable(explicitToJson: true)
class GetOrderResponseDto {
  GetOrderResponseDto({
    this.storeId,
    this.status,
    this.price,
    this.items,
  });

  factory GetOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetOrderResponseDtoFromJson(json);

  @JsonKey(name: 'storeId', includeIfNull: false)
  final String? storeId;
  @JsonKey(
      name: 'status',
      includeIfNull: false,
      toJson: orderStatusToJson,
      fromJson: orderStatusFromJson)
  final enums.OrderStatus? status;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(
      name: 'items', includeIfNull: false, defaultValue: <OrderItemModel>[])
  final List<OrderItemModel>? items;
  static const fromJsonFactory = _$GetOrderResponseDtoFromJson;
  static const toJsonFactory = _$GetOrderResponseDtoToJson;
  Map<String, dynamic> toJson() => _$GetOrderResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetOrderResponseDto &&
            (identical(other.storeId, storeId) ||
                const DeepCollectionEquality()
                    .equals(other.storeId, storeId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(storeId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $GetOrderResponseDtoExtension on GetOrderResponseDto {
  GetOrderResponseDto copyWith(
      {String? storeId,
      enums.OrderStatus? status,
      double? price,
      List<OrderItemModel>? items}) {
    return GetOrderResponseDto(
        storeId: storeId ?? this.storeId,
        status: status ?? this.status,
        price: price ?? this.price,
        items: items ?? this.items);
  }
}

@JsonSerializable(explicitToJson: true)
class GetUserResponseDto {
  GetUserResponseDto({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
  });

  factory GetUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseDtoFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'firstName', includeIfNull: false)
  final String? firstName;
  @JsonKey(name: 'lastName', includeIfNull: false)
  final String? lastName;
  static const fromJsonFactory = _$GetUserResponseDtoFromJson;
  static const toJsonFactory = _$GetUserResponseDtoToJson;
  Map<String, dynamic> toJson() => _$GetUserResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetUserResponseDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      runtimeType.hashCode;
}

extension $GetUserResponseDtoExtension on GetUserResponseDto {
  GetUserResponseDto copyWith(
      {String? id, DateTime? createdAt, String? firstName, String? lastName}) {
    return GetUserResponseDto(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName);
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  OrderItemModel({
    this.id,
    this.createdAt,
    this.name,
    this.price,
    this.comment,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'comment', includeIfNull: false)
  final String? comment;
  static const fromJsonFactory = _$OrderItemModelFromJson;
  static const toJsonFactory = _$OrderItemModelToJson;
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderItemModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality().equals(other.comment, comment)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(comment) ^
      runtimeType.hashCode;
}

extension $OrderItemModelExtension on OrderItemModel {
  OrderItemModel copyWith(
      {String? id,
      DateTime? createdAt,
      String? name,
      double? price,
      String? comment}) {
    return OrderItemModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        price: price ?? this.price,
        comment: comment ?? this.comment);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenModel {
  TokenModel({
    this.id,
    this.createdAt,
    this.playerId,
    this.device,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'playerId', includeIfNull: false)
  final String? playerId;
  @JsonKey(
      name: 'device',
      includeIfNull: false,
      toJson: tokenDeviceToJson,
      fromJson: tokenDeviceFromJson)
  final enums.TokenDevice? device;
  static const fromJsonFactory = _$TokenModelFromJson;
  static const toJsonFactory = _$TokenModelToJson;
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.playerId, playerId) ||
                const DeepCollectionEquality()
                    .equals(other.playerId, playerId)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(playerId) ^
      const DeepCollectionEquality().hash(device) ^
      runtimeType.hashCode;
}

extension $TokenModelExtension on TokenModel {
  TokenModel copyWith(
      {String? id,
      DateTime? createdAt,
      String? playerId,
      enums.TokenDevice? device}) {
    return TokenModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        playerId: playerId ?? this.playerId,
        device: device ?? this.device);
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateStatusOrderModel {
  UpdateStatusOrderModel({
    this.orderId,
    this.orderStatus,
  });

  factory UpdateStatusOrderModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateStatusOrderModelFromJson(json);

  @JsonKey(name: 'orderId', includeIfNull: false)
  final String? orderId;
  @JsonKey(
      name: 'orderStatus',
      includeIfNull: false,
      toJson: orderStatusToJson,
      fromJson: orderStatusFromJson)
  final enums.OrderStatus? orderStatus;
  static const fromJsonFactory = _$UpdateStatusOrderModelFromJson;
  static const toJsonFactory = _$UpdateStatusOrderModelToJson;
  Map<String, dynamic> toJson() => _$UpdateStatusOrderModelToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateStatusOrderModel &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality()
                    .equals(other.orderId, orderId)) &&
            (identical(other.orderStatus, orderStatus) ||
                const DeepCollectionEquality()
                    .equals(other.orderStatus, orderStatus)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(orderStatus) ^
      runtimeType.hashCode;
}

extension $UpdateStatusOrderModelExtension on UpdateStatusOrderModel {
  UpdateStatusOrderModel copyWith(
      {String? orderId, enums.OrderStatus? orderStatus}) {
    return UpdateStatusOrderModel(
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus);
  }
}

String? orderStatusToJson(enums.OrderStatus? orderStatus) {
  return enums.$OrderStatusMap[orderStatus];
}

enums.OrderStatus orderStatusFromJson(String? orderStatus) {
  if (orderStatus == null) {
    return enums.OrderStatus.swaggerGeneratedUnknown;
  }

  return enums.$OrderStatusMap.entries
      .firstWhere(
          (element) => element.value.toLowerCase() == orderStatus.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.OrderStatus.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> orderStatusListToJson(List<enums.OrderStatus>? orderStatus) {
  if (orderStatus == null) {
    return [];
  }

  return orderStatus.map((e) => enums.$OrderStatusMap[e]!).toList();
}

List<enums.OrderStatus> orderStatusListFromJson(List? orderStatus) {
  if (orderStatus == null) {
    return [];
  }

  return orderStatus.map((e) => orderStatusFromJson(e.toString())).toList();
}

String? tokenDeviceToJson(enums.TokenDevice? tokenDevice) {
  return enums.$TokenDeviceMap[tokenDevice];
}

enums.TokenDevice tokenDeviceFromJson(String? tokenDevice) {
  if (tokenDevice == null) {
    return enums.TokenDevice.swaggerGeneratedUnknown;
  }

  return enums.$TokenDeviceMap.entries
      .firstWhere(
          (element) => element.value.toLowerCase() == tokenDevice.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.TokenDevice.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> tokenDeviceListToJson(List<enums.TokenDevice>? tokenDevice) {
  if (tokenDevice == null) {
    return [];
  }

  return tokenDevice.map((e) => enums.$TokenDeviceMap[e]!).toList();
}

List<enums.TokenDevice> tokenDeviceListFromJson(List? tokenDevice) {
  if (tokenDevice == null) {
    return [];
  }

  return tokenDevice.map((e) => tokenDeviceFromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(SwaggerJsonDecoderMappings);

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
