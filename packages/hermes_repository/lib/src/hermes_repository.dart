import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:hermes_api/hermes_api.dart';

class HermesRepository {
  HermesRepository(
      {required String apiUrl, required this.authenticationRepository}) {
    _chopperClient = ChopperClient(
      baseUrl: apiUrl,
      services: [Swagger.create(ChopperClient())],
      converter: JsonSerializableConverter(SwaggerJsonDecoderMappings),
      interceptors: [_authHeader],
    );
  }

  late ChopperClient _chopperClient;
  final AuthenticationRepository authenticationRepository;

  Swagger get client => _chopperClient.getService<Swagger>();

  Future<Request> _authHeader(Request request) async {
    final Map<String, String> updatedHeaders =
        Map<String, String>.of(request.headers);

    final token =
        await authenticationRepository.firebaseAuth.currentUser?.getIdToken();
    updatedHeaders.putIfAbsent(
      'Authorization',
      () => 'Bearer $token',
    );

    return request.copyWith(headers: updatedHeaders);
  }
}
