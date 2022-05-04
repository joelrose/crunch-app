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

  Future<GetMenuResponseDto> apiMenusMenuIdGet({
    required String storeId,
  }) async {
    try {
      final request = await client.apiMenusMenuIdGet(
        menuId: storeId,
      );

      if (request.isSuccessful) {
        request.body?.menu?.categories?.sort(
          (a, b) => a.sortOrder!.compareTo(b.sortOrder!),
        );

        if (request.body?.menu?.categories != null) {
          for (final category in request.body!.menu!.categories!) {
            category.products?.sort(
              (a, b) => a.product!.sortOrder!.compareTo(b.product!.sortOrder!),
            );
          }
        }

        return request.body!;
      } else {
        throw Exception();
      }
    } catch (exception) {
      throw Exception();
    }
  }
}
