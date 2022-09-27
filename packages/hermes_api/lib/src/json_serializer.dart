import 'package:chopper/chopper.dart';

class JsonSerializableConverter extends JsonConverter {
  const JsonSerializableConverter(this.factories);

  final Map<Type, Object Function(Map<String, dynamic>)> factories;

  T? _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];

    if (jsonFactory == null) {
      return null;
    }

    final t = jsonFactory(values);

    return t as T;
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v) as T).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }

  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    final jsonRes = super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(
      body: _decode<Item>(jsonRes.body) as ResultType,
    );
  }

  @override
  Response convertError<ResultType, Item>(Response response) =>
      decodeJson(response);
}
