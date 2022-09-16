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
  Future<Response<List<GetOrdersResponse>>> _ordersGet(
      {String? authorization}) {
    final $url = '/orders';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<GetOrdersResponse>, GetOrdersResponse>($request);
  }

  @override
  Future<Response<CreateOrderResponse>> _ordersPost(
      {required CreateOrderRequest? request, String? authorization}) {
    final $url = '/orders';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $body = request;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<CreateOrderResponse, CreateOrderResponse>($request);
  }

  @override
  Future<Response<GetStoreResponse>> _storeIdGet(
      {required String? id, String? authorization}) {
    final $url = '/store/${id}';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<GetStoreResponse, GetStoreResponse>($request);
  }

  @override
  Future<Response<List<GetStoresOverviewResponse>>> _storesGet(
      {String? authorization}) {
    final $url = '/stores';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<GetStoresOverviewResponse>,
        GetStoresOverviewResponse>($request);
  }

  @override
  Future<Response<User>> _usersGet({String? authorization}) {
    final $url = '/users';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<User, User>($request);
  }

  @override
  Future<Response<dynamic>> _usersPost(
      {required CreateUserRequest? request, String? authorization}) {
    final $url = '/users';
    final $headers = {
      if (authorization != null) 'Authorization': authorization,
    };

    final $body = request;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
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
