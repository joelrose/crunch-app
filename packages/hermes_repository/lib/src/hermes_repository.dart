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
      baseUrl: apiUrl + '/api/v1',
      services: [Swagger.create()],
      converter: JsonSerializableConverter(generatedMapping),
      interceptors: [
        VersionRequestInterceptor(
          appVersion: appVersion,
        ),
        TokenRequestInterceptor(
          authenticationRepository: authenticationRepository,
        ),
        VersionResponseInterceptor(
            appOutdatedRepository: appOutdatedRepository),
      ],
    );
  }

  late final ChopperClient _chopperClient;

  Swagger get client => _chopperClient.getService<Swagger>();
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
