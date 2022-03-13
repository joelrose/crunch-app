import 'package:hermes_api/hermes_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pickup/services/hermes_service.dart';

class MockHermesService implements HermesService {
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
      services: [Swagger.create(ChopperClient())],
      converter: JsonSerializableConverter(SwaggerJsonDecoderMappings),
    );
  }

  late ChopperClient _chopperClient;

  @override
  Swagger get client => _chopperClient.getService<Swagger>();
}
