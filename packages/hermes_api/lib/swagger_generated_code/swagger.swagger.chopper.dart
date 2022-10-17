// Generated code

part of 'swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Swagger extends Swagger {
  _$Swagger([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Swagger;

  @override
  Future<Response<List<GetOrdersResponse>>> _appV1OrdersGet() {
    final $url = '/app/v1/orders';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetOrdersResponse>, GetOrdersResponse>($request);
  }

  @override
  Future<Response<CreateOrderResponse>> _appV1OrdersPost(
      {required CreateOrderRequest? request}) {
    final $url = '/app/v1/orders';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<CreateOrderResponse, CreateOrderResponse>($request);
  }

  @override
  Future<Response<GetStoreResponse>> _appV1StoreIdGet({required String? id}) {
    final $url = '/app/v1/store/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<GetStoreResponse, GetStoreResponse>($request);
  }

  @override
  Future<Response<List<GetStoresOverviewResponse>>> _appV1StoresGet() {
    final $url = '/app/v1/stores';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetStoresOverviewResponse>,
        GetStoresOverviewResponse>($request);
  }

  @override
  Future<Response<User>> _appV1UsersGet() {
    final $url = '/app/v1/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<User, User>($request);
  }

  @override
  Future<Response<dynamic>> _appV1UsersPost(
      {required CreateUserRequest? request}) {
    final $url = '/app/v1/users';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<bool>> _appV1WhitelistPost(
      {required WhitelistRequest? request}) {
    final $url = '/app/v1/whitelist';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<List<Menu>>> _dashboardV1MenuGet() {
    final $url = '/dashboard/v1/menu';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Menu>, Menu>($request);
  }

  @override
  Future<Response<List<GetOrdersResponse>>> _dashboardV1OrdersGet() {
    final $url = '/dashboard/v1/orders';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetOrdersResponse>, GetOrdersResponse>($request);
  }

  @override
  Future<Response<List<GetStoreProduct>>> _dashboardV1ProductsGet() {
    final $url = '/dashboard/v1/products';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetStoreProduct>, GetStoreProduct>($request);
  }
}
