import 'dart:async';

import 'package:app_outdated_repository/app_outdated_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:hermes_api/hermes_api.dart';

class HermesRepository {
  HermesRepository({
    required String apiUrl,
    required AuthenticationRepository authenticationRepository,
    required AppOutdatedRepository appOutdatedRepository,
    required String appVersion,
  }) {
    _chopperClient = ChopperClient(
      baseUrl: apiUrl,
      services: [Swagger.create(ChopperClient())],
      converter: JsonSerializableConverter(SwaggerJsonDecoderMappings),
      interceptors: [
        VersionRequestInterceptor(
          appVersion: appVersion,
        ),
        TokenRequestInterceptor(
          authenticationRepository: authenticationRepository,
        ),
        VersionResponseInterceptor(appOutdatedRepository: appOutdatedRepository),
      ],
    );
  }

  late final ChopperClient _chopperClient;

  Swagger get client => _chopperClient.getService<Swagger>();

  Future<GetMenuResponseDto> apiMenusMenuIdGet({
    required String storeId,
  }) async {
    void _sortItems(List<ProductRelationModelDto>? list) {
      if (list == null) {
        return;
      }

      list.sort(
        (a, b) =>
            a.childProduct!.sortOrder!.compareTo(b.childProduct!.sortOrder!),
      );

      for (final element in list) {
        _sortItems(element.childProduct!.childProducts);
      }
    }

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
            if (category.products != null) {
              category.products?.sort(
                (a, b) =>
                    a.product!.sortOrder!.compareTo(b.product!.sortOrder!),
              );

              for (final product in category.products!) {
                _sortItems(product.product?.childProducts);
              }
            }
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

class VersionRequestInterceptor implements RequestInterceptor {
  VersionRequestInterceptor({required this.appVersion});

  final String appVersion;

  @override
  FutureOr<Request> onRequest(Request request) async {
    return applyHeader(request, 'X-App-Version', appVersion);
  }
}

class TokenRequestInterceptor implements RequestInterceptor {
  TokenRequestInterceptor({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  FutureOr<Request> onRequest(Request request) async {
    final token =
        await authenticationRepository.firebaseAuth.currentUser?.getIdToken();

    return applyHeader(request, 'Authorization', 'Bearer $token');
  }
}

class VersionResponseInterceptor implements ResponseInterceptor {
  VersionResponseInterceptor({required this.appOutdatedRepository});

  final AppOutdatedRepository appOutdatedRepository;

  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode == 412) {
      appOutdatedRepository.pushOutdated();
    }

    return response;
  }
}
