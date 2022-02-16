import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';

class HermesService {
  HermesService() {
    _chopperClient = ChopperClient(
      baseUrl: dotenv.get('API_URL'),
      services: [Swagger.create(ChopperClient())],
      converter: JsonSerializableConverter(SwaggerJsonDecoderMappings),
      interceptors: [authHeader],
    );
  }

  late ChopperClient _chopperClient;
  final AuthService _authService = locator<AuthService>();

  Swagger get client => _chopperClient.getService<Swagger>();

  Future<Request> authHeader(Request request) async {
    final Map<String, String> updatedHeaders =
        Map<String, String>.of(request.headers);

    final token = await _authService.firebaseAuth.currentUser!.getIdToken();
    updatedHeaders.putIfAbsent(
      'Authorization',
      () => 'Bearer $token',
    );

    return request.copyWith(headers: updatedHeaders);
  }
}
