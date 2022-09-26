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
  Future<Response<List<Menu>>> _dashboardMenuGet() {
    final $url = '/dashboard/menu';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Menu>, Menu>($request);
  }

  @override
  Future<Response<List<GetOrdersResponse>>> _dashboardOrdersGet() {
    final $url = '/dashboard/orders';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetOrdersResponse>, GetOrdersResponse>($request);
  }

  @override
  Future<Response<List<GetOrdersResponse>>> _ordersGet() {
    final $url = '/orders';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetOrdersResponse>, GetOrdersResponse>($request);
  }

  @override
  Future<Response<CreateOrderResponse>> _ordersPost(
      {required CreateOrderRequest? request}) {
    final $url = '/orders';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<CreateOrderResponse, CreateOrderResponse>($request);
  }

  @override
  Future<Response<GetStoreResponse>> _storeIdGet({required String? id}) {
    final $url = '/store/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<GetStoreResponse, GetStoreResponse>($request);
  }

  @override
  Future<Response<List<GetStoresOverviewResponse>>> _storesGet() {
    final $url = '/stores';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<GetStoresOverviewResponse>,
        GetStoresOverviewResponse>($request);
  }

  @override
  Future<Response<User>> _usersGet() {
    final $url = '/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<User, User>($request);
  }

  @override
  Future<Response<dynamic>> _usersPost({required CreateUserRequest? request}) {
    final $url = '/users';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<bool>> _whitelistPost({required WhitelistRequest? request}) {
    final $url = '/whitelist';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<bool, bool>($request);
  }
}
