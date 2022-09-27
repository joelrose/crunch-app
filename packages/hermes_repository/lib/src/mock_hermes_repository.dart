import 'package:hermes_repository/hermes_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class MockHermesService implements HermesRepository {
  MockHermesService(
    String response,
    int statusCode, {
    bool throwException = false,
  }) {
    _chopperClient = ChopperClient(
      client: MockClient((request) async {
        if (throwException) {
          throw Exception();
        }
        return http.Response(response, statusCode);
      }),
      services: [Swagger.create()],
      converter: JsonSerializableConverter(generatedMapping),
    );
  }

  String? appVersion;
  late ChopperClient _chopperClient;

  @override
  Swagger get client => _chopperClient.getService<Swagger>();
}
