//Generated code

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
  Future<Response<Order>> apiOrderOrderIdGet({required String? orderId}) {
    final $url = '/api/order/$orderId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Order, Order>($request);
  }

  @override
  Future<Response<List<Order>>> apiOrderGet() {
    final $url = '/api/order';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Order>, Order>($request);
  }

  @override
  Future<Response<dynamic>> apiOrderPost({required CreateOrderRequest? body}) {
    final $url = '/api/order';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
