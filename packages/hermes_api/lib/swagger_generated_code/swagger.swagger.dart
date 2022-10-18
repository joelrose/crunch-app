import 'swagger.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;
export 'swagger.models.swagger.dart';

part 'swagger.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create(
      {ChopperClient? client,
      Authenticator? authenticator,
      String? baseUrl,
      Iterable<dynamic>? interceptors}) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
      services: [_$Swagger()],
      converter: $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      authenticator: authenticator, /*baseUrl: YOUR_BASE_URL*/
    );
    return _$Swagger(newClient);
  }

  ///Get all orders from a user
  Future<chopper.Response<List<GetOrdersResponse>>> appV1OrdersGet() {
    generatedMapping.putIfAbsent(
        GetOrdersResponse, () => GetOrdersResponse.fromJsonFactory);

    return _appV1OrdersGet();
  }

  ///Get all orders from a user
  @Get(path: '/app/v1/orders')
  Future<chopper.Response<List<GetOrdersResponse>>> _appV1OrdersGet();

  ///Create Order for a store
  ///@param request body
  Future<chopper.Response<CreateOrderResponse>> appV1OrdersPost(
      {required CreateOrderRequest? request}) {
    generatedMapping.putIfAbsent(
        CreateOrderRequest, () => CreateOrderRequest.fromJsonFactory);
    generatedMapping.putIfAbsent(
        CreateOrderResponse, () => CreateOrderResponse.fromJsonFactory);

    return _appV1OrdersPost(request: request);
  }

  ///Create Order for a store
  ///@param request body
  @Post(path: '/app/v1/orders')
  Future<chopper.Response<CreateOrderResponse>> _appV1OrdersPost(
      {@Body() required CreateOrderRequest? request});

  ///Get menu for a given store
  ///@param id Id of the store
  Future<chopper.Response<GetStoreResponse>> appV1StoreIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        GetStoreResponse, () => GetStoreResponse.fromJsonFactory);

    return _appV1StoreIdGet(id: id);
  }

  ///Get menu for a given store
  ///@param id Id of the store
  @Get(path: '/app/v1/store/{id}')
  Future<chopper.Response<GetStoreResponse>> _appV1StoreIdGet(
      {@Path('id') required String? id});

  ///Get all open stores
  Future<chopper.Response<List<GetStoresOverviewResponse>>> appV1StoresGet() {
    generatedMapping.putIfAbsent(GetStoresOverviewResponse,
        () => GetStoresOverviewResponse.fromJsonFactory);

    return _appV1StoresGet();
  }

  ///Get all open stores
  @Get(path: '/app/v1/stores')
  Future<chopper.Response<List<GetStoresOverviewResponse>>> _appV1StoresGet();

  ///Get User associated with the given Firebase Token
  Future<chopper.Response<User>> appV1UsersGet() {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _appV1UsersGet();
  }

  ///Get User associated with the given Firebase Token
  @Get(path: '/app/v1/users')
  Future<chopper.Response<User>> _appV1UsersGet();

  ///Create User associated with the given Firebase Token
  ///@param request body
  Future<chopper.Response> appV1UsersPost(
      {required CreateUserRequest? request}) {
    generatedMapping.putIfAbsent(
        CreateUserRequest, () => CreateUserRequest.fromJsonFactory);

    return _appV1UsersPost(request: request);
  }

  ///Create User associated with the given Firebase Token
  ///@param request body
  @Post(path: '/app/v1/users')
  Future<chopper.Response> _appV1UsersPost(
      {@Body() required CreateUserRequest? request});

  ///Check if identifier is whitelisted
  ///@param request body
  Future<chopper.Response<bool>> appV1WhitelistPost(
      {required WhitelistRequest? request}) {
    generatedMapping.putIfAbsent(
        WhitelistRequest, () => WhitelistRequest.fromJsonFactory);

    return _appV1WhitelistPost(request: request);
  }

  ///Check if identifier is whitelisted
  ///@param request body
  @Post(path: '/app/v1/whitelist')
  Future<chopper.Response<bool>> _appV1WhitelistPost(
      {@Body() required WhitelistRequest? request});

  ///Get the menu for a store
  Future<chopper.Response<List<Menu>>> dashboardV1MenuGet() {
    generatedMapping.putIfAbsent(Menu, () => Menu.fromJsonFactory);

    return _dashboardV1MenuGet();
  }

  ///Get the menu for a store
  @Get(path: '/dashboard/v1/menu')
  Future<chopper.Response<List<Menu>>> _dashboardV1MenuGet();

  ///Get all orders from a store
  Future<chopper.Response<List<GetOrdersResponse>>> dashboardV1OrdersGet() {
    generatedMapping.putIfAbsent(
        GetOrdersResponse, () => GetOrdersResponse.fromJsonFactory);

    return _dashboardV1OrdersGet();
  }

  ///Get all orders from a store
  @Get(path: '/dashboard/v1/orders')
  Future<chopper.Response<List<GetOrdersResponse>>> _dashboardV1OrdersGet();

  ///Get all products from a store
  Future<chopper.Response<List<GetStoreProduct>>> dashboardV1ProductsGet() {
    generatedMapping.putIfAbsent(
        GetStoreProduct, () => GetStoreProduct.fromJsonFactory);

    return _dashboardV1ProductsGet();
  }

  ///Get all products from a store
  @Get(path: '/dashboard/v1/products')
  Future<chopper.Response<List<GetStoreProduct>>> _dashboardV1ProductsGet();
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

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
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

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
