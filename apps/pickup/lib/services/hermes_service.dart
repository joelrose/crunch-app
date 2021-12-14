import 'dart:async';

import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/auth_service.dart';
import 'package:pickup/services/service_locator.dart';

class HermesService {
  HermesService() {
    _chopperClient = ChopperClient(
      baseUrl: 'http://localhost:5000',
      services: [Swagger.create(ChopperClient())],
      converter: JsonSerializableConverter(SwaggerJsonDecoderMappings),
      interceptors: [authHeader],
    );
  }

  late ChopperClient _chopperClient;
  final AuthService _authService = locator<AuthService>();

  Swagger get chopperClient => _chopperClient.getService<Swagger>();

  Future<Request> authHeader(Request request) async {
    final Map<String, String> updatedHeaders =
        Map<String, String>.of(request.headers);

    final token = await _authService.firebaseAuth.currentUser!.getIdToken();
    final bearerToken = 'Bearer $token';
    updatedHeaders.putIfAbsent(
      'Authorization',
      () => bearerToken,
    );

    return request.copyWith(headers: updatedHeaders);
  }

  Future<String> getBearerToken() async {
    final token = await _authService.firebaseAuth.currentUser!.getIdToken();
    return 'Bearer $token';
  }
}
