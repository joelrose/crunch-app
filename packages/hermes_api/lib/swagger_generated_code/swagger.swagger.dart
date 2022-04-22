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
  @Get(path: '/api/menus')
  Future<chopper.Response<List<GetMenusResponseDto>>> apiMenusGet();

  ///
  ///@param menuId
  @Get(path: '/api/menus/{menuId}')
  Future<chopper.Response<GetMenuResponseDto>> apiMenusMenuIdGet(
      {@Path('menuId') required String? menuId});

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
  @Post(path: '/api/users')
  Future<chopper.Response<bool>> apiUsersPost(
      {@Body() required CreateUserRequestDto? body});

  ///
  @Delete(path: '/api/users')
  Future<chopper.Response<bool>> apiUsersDelete();

  ///
  @Get(path: '/api/users')
  Future<chopper.Response<GetUserResponseDto>> apiUsersGet();

  ///
  @Post(path: '/api/whitelistuser')
  Future<chopper.Response<bool>> apiWhitelistuserPost(
      {@Body() required String? body});
}

final Map<Type, Object Function(Map<String, dynamic>)>
    SwaggerJsonDecoderMappings = {
  CategoryRelationModelDto: CategoryRelationModelDto.fromJsonFactory,
  CreateOrderItemDto: CreateOrderItemDto.fromJsonFactory,
  CreateOrderRequestDto: CreateOrderRequestDto.fromJsonFactory,
  CreateOrderResponseDto: CreateOrderResponseDto.fromJsonFactory,
  CreateUserRequestDto: CreateUserRequestDto.fromJsonFactory,
  DeliverectAvailabilityModel: DeliverectAvailabilityModel.fromJsonFactory,
  DeliverectCategoryModelDto: DeliverectCategoryModelDto.fromJsonFactory,
  DeliverectMenuDto: DeliverectMenuDto.fromJsonFactory,
  DeliverectMenusDto: DeliverectMenusDto.fromJsonFactory,
  DeliverectProductModelDto: DeliverectProductModelDto.fromJsonFactory,
  GetMenuResponseDto: GetMenuResponseDto.fromJsonFactory,
  GetMenusResponseDto: GetMenusResponseDto.fromJsonFactory,
  GetOrderResponseDto: GetOrderResponseDto.fromJsonFactory,
  GetUserResponseDto: GetUserResponseDto.fromJsonFactory,
  MerchantModelDto: MerchantModelDto.fromJsonFactory,
  OrderItemModel: OrderItemModel.fromJsonFactory,
  ProductRelationModelDto: ProductRelationModelDto.fromJsonFactory,
  UpdateStatusOrderModel: UpdateStatusOrderModel.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class CategoryRelationModelDto {
  CategoryRelationModelDto({
    this.product,
  });

  factory CategoryRelationModelDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryRelationModelDtoFromJson(json);

  @JsonKey(name: 'product', includeIfNull: false)
  final DeliverectProductModelDto? product;
  static const fromJsonFactory = _$CategoryRelationModelDtoFromJson;
  static const toJsonFactory = _$CategoryRelationModelDtoToJson;
  Map<String, dynamic> toJson() => _$CategoryRelationModelDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CategoryRelationModelDto &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(other.product, product)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(product) ^ runtimeType.hashCode;
}

extension $CategoryRelationModelDtoExtension on CategoryRelationModelDto {
  CategoryRelationModelDto copyWith({DeliverectProductModelDto? product}) {
    return CategoryRelationModelDto(product: product ?? this.product);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderItemDto {
  CreateOrderItemDto({
    this.plu,
    this.name,
    this.price,
    this.quantity,
    this.items,
  });

  factory CreateOrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderItemDtoFromJson(json);

  @JsonKey(name: 'plu', includeIfNull: false)
  final String? plu;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'quantity', includeIfNull: false)
  int? quantity;
  @JsonKey(
      name: 'items', includeIfNull: false, defaultValue: <CreateOrderItemDto>[])
  final List<CreateOrderItemDto>? items;
  static const fromJsonFactory = _$CreateOrderItemDtoFromJson;
  static const toJsonFactory = _$CreateOrderItemDtoToJson;
  Map<String, dynamic> toJson() => _$CreateOrderItemDtoToJson(this);

  // TODO: remove quantity check
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderItemDto &&
            (identical(other.plu, plu) ||
                const DeepCollectionEquality().equals(other.plu, plu)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(other.quantity, quantity)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(plu) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $CreateOrderItemDtoExtension on CreateOrderItemDto {
  CreateOrderItemDto copyWith(
      {String? plu,
      String? name,
      int? price,
      int? quantity,
      List<CreateOrderItemDto>? items}) {
    return CreateOrderItemDto(
        plu: plu ?? this.plu,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        items: items ?? this.items);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderRequestDto {
  CreateOrderRequestDto({
    this.merchantId,
    this.items,
  });

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);

  @JsonKey(name: 'merchantId', includeIfNull: false)
  final String? merchantId;
  @JsonKey(
      name: 'items', includeIfNull: false, defaultValue: <CreateOrderItemDto>[])
  final List<CreateOrderItemDto>? items;
  static const fromJsonFactory = _$CreateOrderRequestDtoFromJson;
  static const toJsonFactory = _$CreateOrderRequestDtoToJson;
  Map<String, dynamic> toJson() => _$CreateOrderRequestDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateOrderRequestDto &&
            (identical(other.merchantId, merchantId) ||
                const DeepCollectionEquality()
                    .equals(other.merchantId, merchantId)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(merchantId) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $CreateOrderRequestDtoExtension on CreateOrderRequestDto {
  CreateOrderRequestDto copyWith(
      {String? merchantId, List<CreateOrderItemDto>? items}) {
    return CreateOrderRequestDto(
        merchantId: merchantId ?? this.merchantId, items: items ?? this.items);
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
class CreateUserRequestDto {
  CreateUserRequestDto({
    this.firstName,
    this.lastName,
    this.languageCode,
  });

  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);

  @JsonKey(name: 'firstName', includeIfNull: false)
  final String? firstName;
  @JsonKey(name: 'lastName', includeIfNull: false)
  final String? lastName;
  @JsonKey(name: 'languageCode', includeIfNull: false)
  final String? languageCode;
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
                    .equals(other.lastName, lastName)) &&
            (identical(other.languageCode, languageCode) ||
                const DeepCollectionEquality()
                    .equals(other.languageCode, languageCode)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(languageCode) ^
      runtimeType.hashCode;
}

extension $CreateUserRequestDtoExtension on CreateUserRequestDto {
  CreateUserRequestDto copyWith(
      {String? firstName, String? lastName, String? languageCode}) {
    return CreateUserRequestDto(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        languageCode: languageCode ?? this.languageCode);
  }
}

@JsonSerializable(explicitToJson: true)
class DeliverectAvailabilityModel {
  DeliverectAvailabilityModel({
    this.id,
    this.createdAt,
    this.dayOfWeek,
    this.endTime,
    this.startTime,
  });

  factory DeliverectAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$DeliverectAvailabilityModelFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(
      name: 'dayOfWeek',
      includeIfNull: false,
      toJson: deliverectDayToJson,
      fromJson: deliverectDayFromJson)
  final enums.DeliverectDay? dayOfWeek;
  @JsonKey(name: 'endTime', includeIfNull: false)
  final String? endTime;
  @JsonKey(name: 'startTime', includeIfNull: false)
  final String? startTime;
  static const fromJsonFactory = _$DeliverectAvailabilityModelFromJson;
  static const toJsonFactory = _$DeliverectAvailabilityModelToJson;
  Map<String, dynamic> toJson() => _$DeliverectAvailabilityModelToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliverectAvailabilityModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfWeek, dayOfWeek)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality()
                    .equals(other.endTime, endTime)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(dayOfWeek) ^
      const DeepCollectionEquality().hash(endTime) ^
      const DeepCollectionEquality().hash(startTime) ^
      runtimeType.hashCode;
}

extension $DeliverectAvailabilityModelExtension on DeliverectAvailabilityModel {
  DeliverectAvailabilityModel copyWith(
      {String? id,
      DateTime? createdAt,
      enums.DeliverectDay? dayOfWeek,
      String? endTime,
      String? startTime}) {
    return DeliverectAvailabilityModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        endTime: endTime ?? this.endTime,
        startTime: startTime ?? this.startTime);
  }
}

@JsonSerializable(explicitToJson: true)
class DeliverectCategoryModelDto {
  DeliverectCategoryModelDto({
    this.id,
    this.createdAt,
    this.categoryId,
    this.account,
    this.description,
    this.imageUrl,
    this.level,
    this.menu,
    this.name,
    this.sortOrder,
    this.products,
  });

  factory DeliverectCategoryModelDto.fromJson(Map<String, dynamic> json) =>
      _$DeliverectCategoryModelDtoFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'categoryId', includeIfNull: false)
  final String? categoryId;
  @JsonKey(name: 'account', includeIfNull: false)
  final String? account;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'level', includeIfNull: false)
  final int? level;
  @JsonKey(name: 'menu', includeIfNull: false)
  final String? menu;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'sortOrder', includeIfNull: false)
  final int? sortOrder;
  @JsonKey(
      name: 'products',
      includeIfNull: false,
      defaultValue: <CategoryRelationModelDto>[])
  final List<CategoryRelationModelDto>? products;
  static const fromJsonFactory = _$DeliverectCategoryModelDtoFromJson;
  static const toJsonFactory = _$DeliverectCategoryModelDtoToJson;
  Map<String, dynamic> toJson() => _$DeliverectCategoryModelDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliverectCategoryModelDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.menu, menu) ||
                const DeepCollectionEquality().equals(other.menu, menu)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.sortOrder, sortOrder) ||
                const DeepCollectionEquality()
                    .equals(other.sortOrder, sortOrder)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(menu) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(sortOrder) ^
      const DeepCollectionEquality().hash(products) ^
      runtimeType.hashCode;
}

extension $DeliverectCategoryModelDtoExtension on DeliverectCategoryModelDto {
  DeliverectCategoryModelDto copyWith(
      {String? id,
      DateTime? createdAt,
      String? categoryId,
      String? account,
      String? description,
      String? imageUrl,
      int? level,
      String? menu,
      String? name,
      int? sortOrder,
      List<CategoryRelationModelDto>? products}) {
    return DeliverectCategoryModelDto(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        categoryId: categoryId ?? this.categoryId,
        account: account ?? this.account,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        level: level ?? this.level,
        menu: menu ?? this.menu,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
        products: products ?? this.products);
  }
}

@JsonSerializable(explicitToJson: true)
class DeliverectMenuDto {
  DeliverectMenuDto({
    this.availabilities,
    this.categories,
    this.channelLinkId,
    this.currency,
    this.description,
    this.menu,
    this.menuId,
    this.menuImageUrl,
    this.menuType,
  });

  factory DeliverectMenuDto.fromJson(Map<String, dynamic> json) =>
      _$DeliverectMenuDtoFromJson(json);

  @JsonKey(
      name: 'availabilities',
      includeIfNull: false,
      defaultValue: <DeliverectAvailabilityModel>[])
  final List<DeliverectAvailabilityModel>? availabilities;
  @JsonKey(
      name: 'categories',
      includeIfNull: false,
      defaultValue: <DeliverectCategoryModelDto>[])
  final List<DeliverectCategoryModelDto>? categories;
  @JsonKey(name: 'channelLinkId', includeIfNull: false)
  final String? channelLinkId;
  @JsonKey(name: 'currency', includeIfNull: false)
  final int? currency;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'menu', includeIfNull: false)
  final String? menu;
  @JsonKey(name: 'menuId', includeIfNull: false)
  final String? menuId;
  @JsonKey(name: 'menuImageUrl', includeIfNull: false)
  final String? menuImageUrl;
  @JsonKey(name: 'menuType', includeIfNull: false)
  final int? menuType;
  static const fromJsonFactory = _$DeliverectMenuDtoFromJson;
  static const toJsonFactory = _$DeliverectMenuDtoToJson;
  Map<String, dynamic> toJson() => _$DeliverectMenuDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliverectMenuDto &&
            (identical(other.availabilities, availabilities) ||
                const DeepCollectionEquality()
                    .equals(other.availabilities, availabilities)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.channelLinkId, channelLinkId) ||
                const DeepCollectionEquality()
                    .equals(other.channelLinkId, channelLinkId)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.menu, menu) ||
                const DeepCollectionEquality().equals(other.menu, menu)) &&
            (identical(other.menuId, menuId) ||
                const DeepCollectionEquality().equals(other.menuId, menuId)) &&
            (identical(other.menuImageUrl, menuImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.menuImageUrl, menuImageUrl)) &&
            (identical(other.menuType, menuType) ||
                const DeepCollectionEquality()
                    .equals(other.menuType, menuType)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(availabilities) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(channelLinkId) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(menu) ^
      const DeepCollectionEquality().hash(menuId) ^
      const DeepCollectionEquality().hash(menuImageUrl) ^
      const DeepCollectionEquality().hash(menuType) ^
      runtimeType.hashCode;
}

extension $DeliverectMenuDtoExtension on DeliverectMenuDto {
  DeliverectMenuDto copyWith(
      {List<DeliverectAvailabilityModel>? availabilities,
      List<DeliverectCategoryModelDto>? categories,
      String? channelLinkId,
      int? currency,
      String? description,
      String? menu,
      String? menuId,
      String? menuImageUrl,
      int? menuType}) {
    return DeliverectMenuDto(
        availabilities: availabilities ?? this.availabilities,
        categories: categories ?? this.categories,
        channelLinkId: channelLinkId ?? this.channelLinkId,
        currency: currency ?? this.currency,
        description: description ?? this.description,
        menu: menu ?? this.menu,
        menuId: menuId ?? this.menuId,
        menuImageUrl: menuImageUrl ?? this.menuImageUrl,
        menuType: menuType ?? this.menuType);
  }
}

@JsonSerializable(explicitToJson: true)
class DeliverectMenusDto {
  DeliverectMenusDto({
    this.availabilities,
    this.description,
    this.menu,
    this.menuId,
    this.menuImageUrl,
    this.menuType,
  });

  factory DeliverectMenusDto.fromJson(Map<String, dynamic> json) =>
      _$DeliverectMenusDtoFromJson(json);

  @JsonKey(
      name: 'availabilities',
      includeIfNull: false,
      defaultValue: <DeliverectAvailabilityModel>[])
  final List<DeliverectAvailabilityModel>? availabilities;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'menu', includeIfNull: false)
  final String? menu;
  @JsonKey(name: 'menuId', includeIfNull: false)
  final String? menuId;
  @JsonKey(name: 'menuImageUrl', includeIfNull: false)
  final String? menuImageUrl;
  @JsonKey(name: 'menuType', includeIfNull: false)
  final int? menuType;
  static const fromJsonFactory = _$DeliverectMenusDtoFromJson;
  static const toJsonFactory = _$DeliverectMenusDtoToJson;
  Map<String, dynamic> toJson() => _$DeliverectMenusDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliverectMenusDto &&
            (identical(other.availabilities, availabilities) ||
                const DeepCollectionEquality()
                    .equals(other.availabilities, availabilities)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.menu, menu) ||
                const DeepCollectionEquality().equals(other.menu, menu)) &&
            (identical(other.menuId, menuId) ||
                const DeepCollectionEquality().equals(other.menuId, menuId)) &&
            (identical(other.menuImageUrl, menuImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.menuImageUrl, menuImageUrl)) &&
            (identical(other.menuType, menuType) ||
                const DeepCollectionEquality()
                    .equals(other.menuType, menuType)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(availabilities) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(menu) ^
      const DeepCollectionEquality().hash(menuId) ^
      const DeepCollectionEquality().hash(menuImageUrl) ^
      const DeepCollectionEquality().hash(menuType) ^
      runtimeType.hashCode;
}

extension $DeliverectMenusDtoExtension on DeliverectMenusDto {
  DeliverectMenusDto copyWith(
      {List<DeliverectAvailabilityModel>? availabilities,
      String? description,
      String? menu,
      String? menuId,
      String? menuImageUrl,
      int? menuType}) {
    return DeliverectMenusDto(
        availabilities: availabilities ?? this.availabilities,
        description: description ?? this.description,
        menu: menu ?? this.menu,
        menuId: menuId ?? this.menuId,
        menuImageUrl: menuImageUrl ?? this.menuImageUrl,
        menuType: menuType ?? this.menuType);
  }
}

@JsonSerializable(explicitToJson: true)
class DeliverectProductModelDto {
  DeliverectProductModelDto({
    this.productId,
    this.account,
    this.deliveryTax,
    this.description,
    this.imageUrl,
    this.location,
    this.max,
    this.min,
    this.multiply,
    this.multiMax,
    this.name,
    this.plu,
    this.price,
    this.productType,
    this.snoozed,
    this.sortOrder,
    this.takeawayTax,
    this.visible,
    this.childProducts,
  });

  factory DeliverectProductModelDto.fromJson(Map<String, dynamic> json) =>
      _$DeliverectProductModelDtoFromJson(json);

  @JsonKey(name: 'productId', includeIfNull: false)
  final String? productId;
  @JsonKey(name: 'account', includeIfNull: false)
  final String? account;
  @JsonKey(name: 'deliveryTax', includeIfNull: false)
  final int? deliveryTax;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'location', includeIfNull: false)
  final String? location;
  @JsonKey(name: 'max', includeIfNull: false)
  final int? max;
  @JsonKey(name: 'min', includeIfNull: false)
  final int? min;
  @JsonKey(name: 'multiply', includeIfNull: false)
  final int? multiply;
  @JsonKey(name: 'multiMax', includeIfNull: false)
  final int? multiMax;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'plu', includeIfNull: false)
  final String? plu;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'productType', includeIfNull: false)
  final int? productType;
  @JsonKey(name: 'snoozed', includeIfNull: false)
  final bool? snoozed;
  @JsonKey(name: 'sortOrder', includeIfNull: false)
  final int? sortOrder;
  @JsonKey(name: 'takeawayTax', includeIfNull: false)
  final int? takeawayTax;
  @JsonKey(name: 'visible', includeIfNull: false)
  final bool? visible;
  @JsonKey(
      name: 'childProducts',
      includeIfNull: false,
      defaultValue: <ProductRelationModelDto>[])
  final List<ProductRelationModelDto>? childProducts;
  static const fromJsonFactory = _$DeliverectProductModelDtoFromJson;
  static const toJsonFactory = _$DeliverectProductModelDtoToJson;
  Map<String, dynamic> toJson() => _$DeliverectProductModelDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliverectProductModelDto &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality()
                    .equals(other.productId, productId)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality()
                    .equals(other.account, account)) &&
            (identical(other.deliveryTax, deliveryTax) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryTax, deliveryTax)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.multiply, multiply) ||
                const DeepCollectionEquality()
                    .equals(other.multiply, multiply)) &&
            (identical(other.multiMax, multiMax) ||
                const DeepCollectionEquality()
                    .equals(other.multiMax, multiMax)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.plu, plu) ||
                const DeepCollectionEquality().equals(other.plu, plu)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.productType, productType) ||
                const DeepCollectionEquality()
                    .equals(other.productType, productType)) &&
            (identical(other.snoozed, snoozed) ||
                const DeepCollectionEquality()
                    .equals(other.snoozed, snoozed)) &&
            (identical(other.sortOrder, sortOrder) ||
                const DeepCollectionEquality()
                    .equals(other.sortOrder, sortOrder)) &&
            (identical(other.takeawayTax, takeawayTax) ||
                const DeepCollectionEquality()
                    .equals(other.takeawayTax, takeawayTax)) &&
            (identical(other.visible, visible) ||
                const DeepCollectionEquality()
                    .equals(other.visible, visible)) &&
            (identical(other.childProducts, childProducts) ||
                const DeepCollectionEquality()
                    .equals(other.childProducts, childProducts)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(deliveryTax) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(multiply) ^
      const DeepCollectionEquality().hash(multiMax) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(plu) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(productType) ^
      const DeepCollectionEquality().hash(snoozed) ^
      const DeepCollectionEquality().hash(sortOrder) ^
      const DeepCollectionEquality().hash(takeawayTax) ^
      const DeepCollectionEquality().hash(visible) ^
      const DeepCollectionEquality().hash(childProducts) ^
      runtimeType.hashCode;
}

extension $DeliverectProductModelDtoExtension on DeliverectProductModelDto {
  DeliverectProductModelDto copyWith(
      {String? productId,
      String? account,
      int? deliveryTax,
      String? description,
      String? imageUrl,
      String? location,
      int? max,
      int? min,
      int? multiply,
      int? multiMax,
      String? name,
      String? plu,
      int? price,
      int? productType,
      bool? snoozed,
      int? sortOrder,
      int? takeawayTax,
      bool? visible,
      List<ProductRelationModelDto>? childProducts}) {
    return DeliverectProductModelDto(
        productId: productId ?? this.productId,
        account: account ?? this.account,
        deliveryTax: deliveryTax ?? this.deliveryTax,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        location: location ?? this.location,
        max: max ?? this.max,
        min: min ?? this.min,
        multiply: multiply ?? this.multiply,
        multiMax: multiMax ?? this.multiMax,
        name: name ?? this.name,
        plu: plu ?? this.plu,
        price: price ?? this.price,
        productType: productType ?? this.productType,
        snoozed: snoozed ?? this.snoozed,
        sortOrder: sortOrder ?? this.sortOrder,
        takeawayTax: takeawayTax ?? this.takeawayTax,
        visible: visible ?? this.visible,
        childProducts: childProducts ?? this.childProducts);
  }
}

@JsonSerializable(explicitToJson: true)
class GetMenuResponseDto {
  GetMenuResponseDto({
    this.id,
    this.phoneNumber,
    this.rating,
    this.reviewCount,
    this.averagePickUpTime,
    this.address,
    this.googleMapsLink,
    this.menu,
  });

  factory GetMenuResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetMenuResponseDtoFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'rating', includeIfNull: false)
  final double? rating;
  @JsonKey(name: 'reviewCount', includeIfNull: false)
  final String? reviewCount;
  @JsonKey(name: 'averagePickUpTime', includeIfNull: false)
  final String? averagePickUpTime;
  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'googleMapsLink', includeIfNull: false)
  final String? googleMapsLink;
  @JsonKey(name: 'menu', includeIfNull: false)
  final DeliverectMenuDto? menu;
  static const fromJsonFactory = _$GetMenuResponseDtoFromJson;
  static const toJsonFactory = _$GetMenuResponseDtoToJson;
  Map<String, dynamic> toJson() => _$GetMenuResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetMenuResponseDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.reviewCount, reviewCount) ||
                const DeepCollectionEquality()
                    .equals(other.reviewCount, reviewCount)) &&
            (identical(other.averagePickUpTime, averagePickUpTime) ||
                const DeepCollectionEquality()
                    .equals(other.averagePickUpTime, averagePickUpTime)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.googleMapsLink, googleMapsLink) ||
                const DeepCollectionEquality()
                    .equals(other.googleMapsLink, googleMapsLink)) &&
            (identical(other.menu, menu) ||
                const DeepCollectionEquality().equals(other.menu, menu)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(reviewCount) ^
      const DeepCollectionEquality().hash(averagePickUpTime) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(googleMapsLink) ^
      const DeepCollectionEquality().hash(menu) ^
      runtimeType.hashCode;
}

extension $GetMenuResponseDtoExtension on GetMenuResponseDto {
  GetMenuResponseDto copyWith(
      {String? id,
      String? phoneNumber,
      double? rating,
      String? reviewCount,
      String? averagePickUpTime,
      String? address,
      String? googleMapsLink,
      DeliverectMenuDto? menu}) {
    return GetMenuResponseDto(
        id: id ?? this.id,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        averagePickUpTime: averagePickUpTime ?? this.averagePickUpTime,
        address: address ?? this.address,
        googleMapsLink: googleMapsLink ?? this.googleMapsLink,
        menu: menu ?? this.menu);
  }
}

@JsonSerializable(explicitToJson: true)
class GetMenusResponseDto {
  GetMenusResponseDto({
    this.id,
    this.rating,
    this.reviewCount,
    this.averagePickUpTime,
    this.menu,
  });

  factory GetMenusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetMenusResponseDtoFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'rating', includeIfNull: false)
  final double? rating;
  @JsonKey(name: 'reviewCount', includeIfNull: false)
  final String? reviewCount;
  @JsonKey(name: 'averagePickUpTime', includeIfNull: false)
  final String? averagePickUpTime;
  @JsonKey(name: 'menu', includeIfNull: false)
  final DeliverectMenusDto? menu;
  static const fromJsonFactory = _$GetMenusResponseDtoFromJson;
  static const toJsonFactory = _$GetMenusResponseDtoToJson;
  Map<String, dynamic> toJson() => _$GetMenusResponseDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetMenusResponseDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.reviewCount, reviewCount) ||
                const DeepCollectionEquality()
                    .equals(other.reviewCount, reviewCount)) &&
            (identical(other.averagePickUpTime, averagePickUpTime) ||
                const DeepCollectionEquality()
                    .equals(other.averagePickUpTime, averagePickUpTime)) &&
            (identical(other.menu, menu) ||
                const DeepCollectionEquality().equals(other.menu, menu)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(reviewCount) ^
      const DeepCollectionEquality().hash(averagePickUpTime) ^
      const DeepCollectionEquality().hash(menu) ^
      runtimeType.hashCode;
}

extension $GetMenusResponseDtoExtension on GetMenusResponseDto {
  GetMenusResponseDto copyWith(
      {String? id,
      double? rating,
      String? reviewCount,
      String? averagePickUpTime,
      DeliverectMenusDto? menu}) {
    return GetMenusResponseDto(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        averagePickUpTime: averagePickUpTime ?? this.averagePickUpTime,
        menu: menu ?? this.menu);
  }
}

@JsonSerializable(explicitToJson: true)
class GetOrderResponseDto {
  GetOrderResponseDto({
    this.id,
    this.status,
    this.price,
    this.estimatedPickUpTime,
    this.merchant,
    this.items,
  });

  factory GetOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetOrderResponseDtoFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(
      name: 'status',
      includeIfNull: false,
      toJson: deliverectOrderStatusToJson,
      fromJson: deliverectOrderStatusFromJson)
  final enums.DeliverectOrderStatus? status;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'estimatedPickUpTime', includeIfNull: false)
  final DateTime? estimatedPickUpTime;
  @JsonKey(name: 'merchant', includeIfNull: false)
  final MerchantModelDto? merchant;
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
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.estimatedPickUpTime, estimatedPickUpTime) ||
                const DeepCollectionEquality()
                    .equals(other.estimatedPickUpTime, estimatedPickUpTime)) &&
            (identical(other.merchant, merchant) ||
                const DeepCollectionEquality()
                    .equals(other.merchant, merchant)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(estimatedPickUpTime) ^
      const DeepCollectionEquality().hash(merchant) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $GetOrderResponseDtoExtension on GetOrderResponseDto {
  GetOrderResponseDto copyWith(
      {String? id,
      enums.DeliverectOrderStatus? status,
      double? price,
      DateTime? estimatedPickUpTime,
      MerchantModelDto? merchant,
      List<OrderItemModel>? items}) {
    return GetOrderResponseDto(
        id: id ?? this.id,
        status: status ?? this.status,
        price: price ?? this.price,
        estimatedPickUpTime: estimatedPickUpTime ?? this.estimatedPickUpTime,
        merchant: merchant ?? this.merchant,
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
class MerchantModelDto {
  MerchantModelDto({
    this.name,
    this.phoneNumber,
    this.rating,
    this.reviewCount,
    this.averagePickUpTime,
    this.address,
    this.googleMapsLink,
  });

  factory MerchantModelDto.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelDtoFromJson(json);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'rating', includeIfNull: false)
  final double? rating;
  @JsonKey(name: 'reviewCount', includeIfNull: false)
  final String? reviewCount;
  @JsonKey(name: 'averagePickUpTime', includeIfNull: false)
  final String? averagePickUpTime;
  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'googleMapsLink', includeIfNull: false)
  final String? googleMapsLink;
  static const fromJsonFactory = _$MerchantModelDtoFromJson;
  static const toJsonFactory = _$MerchantModelDtoToJson;
  Map<String, dynamic> toJson() => _$MerchantModelDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MerchantModelDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.reviewCount, reviewCount) ||
                const DeepCollectionEquality()
                    .equals(other.reviewCount, reviewCount)) &&
            (identical(other.averagePickUpTime, averagePickUpTime) ||
                const DeepCollectionEquality()
                    .equals(other.averagePickUpTime, averagePickUpTime)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.googleMapsLink, googleMapsLink) ||
                const DeepCollectionEquality()
                    .equals(other.googleMapsLink, googleMapsLink)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(reviewCount) ^
      const DeepCollectionEquality().hash(averagePickUpTime) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(googleMapsLink) ^
      runtimeType.hashCode;
}

extension $MerchantModelDtoExtension on MerchantModelDto {
  MerchantModelDto copyWith(
      {String? name,
      String? phoneNumber,
      double? rating,
      String? reviewCount,
      String? averagePickUpTime,
      String? address,
      String? googleMapsLink}) {
    return MerchantModelDto(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        averagePickUpTime: averagePickUpTime ?? this.averagePickUpTime,
        address: address ?? this.address,
        googleMapsLink: googleMapsLink ?? this.googleMapsLink);
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  OrderItemModel({
    this.id,
    this.createdAt,
    this.plu,
    this.name,
    this.price,
    this.quantity,
    this.parent,
    this.parentId,
    this.items,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'plu', includeIfNull: false)
  final String? plu;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'price', includeIfNull: false)
  final int? price;
  @JsonKey(name: 'quantity', includeIfNull: false)
  final int? quantity;
  @JsonKey(name: 'parent', includeIfNull: false)
  final OrderItemModel? parent;
  @JsonKey(name: 'parentId', includeIfNull: false)
  final String? parentId;
  @JsonKey(
      name: 'items', includeIfNull: false, defaultValue: <OrderItemModel>[])
  final List<OrderItemModel>? items;
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
            (identical(other.plu, plu) ||
                const DeepCollectionEquality().equals(other.plu, plu)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.parent, parent) ||
                const DeepCollectionEquality().equals(other.parent, parent)) &&
            (identical(other.parentId, parentId) ||
                const DeepCollectionEquality()
                    .equals(other.parentId, parentId)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(plu) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(parent) ^
      const DeepCollectionEquality().hash(parentId) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $OrderItemModelExtension on OrderItemModel {
  OrderItemModel copyWith(
      {String? id,
      DateTime? createdAt,
      String? plu,
      String? name,
      int? price,
      int? quantity,
      OrderItemModel? parent,
      String? parentId,
      List<OrderItemModel>? items}) {
    return OrderItemModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        plu: plu ?? this.plu,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        parent: parent ?? this.parent,
        parentId: parentId ?? this.parentId,
        items: items ?? this.items);
  }
}

@JsonSerializable(explicitToJson: true)
class ProductRelationModelDto {
  ProductRelationModelDto({
    this.childProduct,
  });

  factory ProductRelationModelDto.fromJson(Map<String, dynamic> json) =>
      _$ProductRelationModelDtoFromJson(json);

  @JsonKey(name: 'childProduct', includeIfNull: false)
  final DeliverectProductModelDto? childProduct;
  static const fromJsonFactory = _$ProductRelationModelDtoFromJson;
  static const toJsonFactory = _$ProductRelationModelDtoToJson;
  Map<String, dynamic> toJson() => _$ProductRelationModelDtoToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProductRelationModelDto &&
            (identical(other.childProduct, childProduct) ||
                const DeepCollectionEquality()
                    .equals(other.childProduct, childProduct)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(childProduct) ^ runtimeType.hashCode;
}

extension $ProductRelationModelDtoExtension on ProductRelationModelDto {
  ProductRelationModelDto copyWith({DeliverectProductModelDto? childProduct}) {
    return ProductRelationModelDto(
        childProduct: childProduct ?? this.childProduct);
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
      toJson: deliverectOrderStatusToJson,
      fromJson: deliverectOrderStatusFromJson)
  final enums.DeliverectOrderStatus? orderStatus;
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
      {String? orderId, enums.DeliverectOrderStatus? orderStatus}) {
    return UpdateStatusOrderModel(
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus);
  }
}

String? deliverectDayToJson(enums.DeliverectDay? deliverectDay) {
  return enums.$DeliverectDayMap[deliverectDay];
}

enums.DeliverectDay deliverectDayFromJson(String? deliverectDay) {
  if (deliverectDay == null) {
    return enums.DeliverectDay.swaggerGeneratedUnknown;
  }

  return enums.$DeliverectDayMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == deliverectDay.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.DeliverectDay.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> deliverectDayListToJson(List<enums.DeliverectDay>? deliverectDay) {
  if (deliverectDay == null) {
    return [];
  }

  return deliverectDay.map((e) => enums.$DeliverectDayMap[e]!).toList();
}

List<enums.DeliverectDay> deliverectDayListFromJson(List? deliverectDay) {
  if (deliverectDay == null) {
    return [];
  }

  return deliverectDay.map((e) => deliverectDayFromJson(e.toString())).toList();
}

String? deliverectOrderStatusToJson(
    enums.DeliverectOrderStatus? deliverectOrderStatus) {
  return enums.$DeliverectOrderStatusMap[deliverectOrderStatus];
}

enums.DeliverectOrderStatus deliverectOrderStatusFromJson(
    String? deliverectOrderStatus) {
  if (deliverectOrderStatus == null) {
    return enums.DeliverectOrderStatus.swaggerGeneratedUnknown;
  }

  return enums.$DeliverectOrderStatusMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() ==
              deliverectOrderStatus.toLowerCase(),
          orElse: () => const MapEntry(
              enums.DeliverectOrderStatus.$new, '10'))
      .key;
}

List<String> deliverectOrderStatusListToJson(
    List<enums.DeliverectOrderStatus>? deliverectOrderStatus) {
  if (deliverectOrderStatus == null) {
    return [];
  }

  return deliverectOrderStatus
      .map((e) => enums.$DeliverectOrderStatusMap[e]!)
      .toList();
}

List<enums.DeliverectOrderStatus> deliverectOrderStatusListFromJson(
    List? deliverectOrderStatus) {
  if (deliverectOrderStatus == null) {
    return [];
  }

  return deliverectOrderStatus
      .map((e) => deliverectOrderStatusFromJson(e.toString()))
      .toList();
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
