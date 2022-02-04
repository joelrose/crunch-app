// Generated code

// ignore_for_file: unnecessary_brace_in_string_interps

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
  Future<Response<CreateOrderResponseDto>> apiOrdersPost(
      {required CreateOrderRequestDto? body}) {
    final $url = '/api/orders';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<CreateOrderResponseDto, CreateOrderResponseDto>($request);
  }

  @override
  Future<Response<bool>> apiOrdersPut({required UpdateStatusOrderModel? body}) {
    final $url = '/api/orders';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<List<GetOrderResponseDto>>> apiOrdersGet() {
    final $url = '/api/orders';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<List<GetOrderResponseDto>, GetOrderResponseDto>($request);
  }

  @override
  Future<Response<GetOrderResponseDto>> apiOrdersOrderIdGet(
      {required String? orderId}) {
    final $url = '/api/orders/${orderId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<GetOrderResponseDto, GetOrderResponseDto>($request);
  }

  @override
  Future<Response<bool>> webhookStripePost() {
    final $url = '/webhook/stripe';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> apiTokensPost({required CreateTokenRequestDto? body}) {
    final $url = '/api/tokens';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<List<TokenModel>>> apiTokensGet() {
    final $url = '/api/tokens';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<TokenModel>, TokenModel>($request);
  }

  @override
  Future<Response<bool>> apiTokensFcmTokenDelete({required String? fcmToken}) {
    final $url = '/api/tokens/${fcmToken}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> apiUsersPost({required CreateUserRequestDto? body}) {
    final $url = '/api/users';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> apiUsersDelete() {
    final $url = '/api/users';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<GetUserResponseDto>> apiUsersGet() {
    final $url = '/api/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<GetUserResponseDto, GetUserResponseDto>($request);
  }
}
