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

  ///Get the menu for a store
  Future<chopper.Response<List<Menu>>> dashboardMenuGet() {
    generatedMapping.putIfAbsent(Menu, () => Menu.fromJsonFactory);

    return _dashboardMenuGet();
  }

  ///Get the menu for a store
  @Get(path: '/dashboard/menu')
  Future<chopper.Response<List<Menu>>> _dashboardMenuGet();

  ///Get all orders from a store
  Future<chopper.Response<List<GetOrdersResponse>>> dashboardOrdersGet() {
    generatedMapping.putIfAbsent(
        GetOrdersResponse, () => GetOrdersResponse.fromJsonFactory);

    return _dashboardOrdersGet();
  }

  ///Get all orders from a store
  @Get(path: '/dashboard/orders')
  Future<chopper.Response<List<GetOrdersResponse>>> _dashboardOrdersGet();

  ///Get all orders from a user
  Future<chopper.Response<List<GetOrdersResponse>>> ordersGet() {
    generatedMapping.putIfAbsent(
        GetOrdersResponse, () => GetOrdersResponse.fromJsonFactory);

    return _ordersGet();
  }

  ///Get all orders from a user
  @Get(path: '/orders')
  Future<chopper.Response<List<GetOrdersResponse>>> _ordersGet();

  ///Create Order for a store
  ///@param request body
  Future<chopper.Response<CreateOrderResponse>> ordersPost(
      {required CreateOrderRequest? request}) {
    generatedMapping.putIfAbsent(
        CreateOrderRequest, () => CreateOrderRequest.fromJsonFactory);
    generatedMapping.putIfAbsent(
        CreateOrderResponse, () => CreateOrderResponse.fromJsonFactory);

    return _ordersPost(request: request);
  }

  ///Create Order for a store
  ///@param request body
  @Post(path: '/orders')
  Future<chopper.Response<CreateOrderResponse>> _ordersPost(
      {@Body() required CreateOrderRequest? request});

  ///Get menu for a given store
  ///@param id Id of the store
  Future<chopper.Response<GetStoreResponse>> storeIdGet({required String? id}) {
    generatedMapping.putIfAbsent(
        GetStoreResponse, () => GetStoreResponse.fromJsonFactory);

    return _storeIdGet(id: id);
  }

  ///Get menu for a given store
  ///@param id Id of the store
  @Get(path: '/store/{id}')
  Future<chopper.Response<GetStoreResponse>> _storeIdGet(
      {@Path('id') required String? id});

  ///Get all open stores
  Future<chopper.Response<List<GetStoresOverviewResponse>>> storesGet() {
    generatedMapping.putIfAbsent(GetStoresOverviewResponse,
        () => GetStoresOverviewResponse.fromJsonFactory);

    return _storesGet();
  }

  ///Get all open stores
  @Get(path: '/stores')
  Future<chopper.Response<List<GetStoresOverviewResponse>>> _storesGet();

  ///Get User associated with the given Firebase Token
  Future<chopper.Response<User>> usersGet() {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _usersGet();
  }

  ///Get User associated with the given Firebase Token
  @Get(path: '/users')
  Future<chopper.Response<User>> _usersGet();

  ///Create User associated with the given Firebase Token
  ///@param request body
  Future<chopper.Response> usersPost({required CreateUserRequest? request}) {
    generatedMapping.putIfAbsent(
        CreateUserRequest, () => CreateUserRequest.fromJsonFactory);

    return _usersPost(request: request);
  }

  ///Create User associated with the given Firebase Token
  ///@param request body
  @Post(path: '/users')
  Future<chopper.Response> _usersPost(
      {@Body() required CreateUserRequest? request});

  ///Check if identifier is whitelisted
  ///@param request body
  Future<chopper.Response<bool>> whitelistPost(
      {required WhitelistRequest? request}) {
    generatedMapping.putIfAbsent(
        WhitelistRequest, () => WhitelistRequest.fromJsonFactory);

    return _whitelistPost(request: request);
  }

  ///Check if identifier is whitelisted
  ///@param request body
  @Post(path: '/whitelist')
  Future<chopper.Response<bool>> _whitelistPost(
      {@Body() required WhitelistRequest? request});
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
