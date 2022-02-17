import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sanity/src/exception.dart';
import 'package:sanity/src/http_client.dart';
import 'package:sanity/src/model.dart';

class SanityClient {
  SanityClient({
    required this.projectId,
    required this.dataset,
    this.useCdn = true,
  });

  final HttpClient _client = HttpClient();
  final String? projectId;
  final String? dataset;
  final bool useCdn;

  Uri _buildUri({String? query, Map<String, dynamic>? params}) {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      'query': query,
      if (params != null) ...params,
    };
    return Uri(
      scheme: 'https',
      host: '$projectId.${useCdn ? 'apicdn' : 'api'}.sanity.io',
      path: '/v1/data/query/$dataset',
      queryParameters: queryParameters,
    );
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson['result'];
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorizedException(response.body);
      case 500:
      default:
        throw FetchDataException(
          'Error occured while communication with server with status code: ${response.statusCode}',
        );
    }
  }

  Future<dynamic> _fetch({String? query, Map<String, dynamic>? params}) async {
    final Uri uri = _buildUri(query: query, params: params);
    final http.Response response = await _client.get(uri);
    return _returnResponse(response);
  }
}

class SanityCms extends SanityClient {
  SanityCms({
    required String? projectId,
    required String? dataset,
    bool useCdn = true,
  }) : super(dataset: dataset, projectId: projectId, useCdn: useCdn);

  final String _restaurantsSanityQuery = '''
  *[_type == 'restaurant' && enabled == true] {
    _id,
    name,
    "image": image.asset->url
  }
  ''';

  final String _restaurantSanityQuery = '''
  *[_id == ':id:'] {
    _id,
    name,
    "image": image.asset->url,
    "description": description[0].children[0].text,
  	address,
    googleMapsUrl,
  	phoneNumber,
  	website,
    menuCateogries[] {
    	title,
      menuItems[] {
        title, 
        price,
        _key,
        description,
        itemOptions[] {
          title,
          options[] {
            _key,
            title, 
            price,
          },
        },
      },
    }
  }
  ''';

  Future<List<RestaurantOverviewModel>> getRestaurants() async {
    final response = await _fetch(query: _restaurantsSanityQuery);

    return response
        .map<RestaurantOverviewModel>(
          (data) => RestaurantOverviewModel.fromMap(
            data as Map<dynamic, dynamic>,
          ),
        )
        .toList() as List<RestaurantOverviewModel>;
  }

  Future<RestaurantStoreModel> getRestaurant(String storeId) async {
    final query = _restaurantSanityQuery.replaceAll(':id:', storeId);

    final response = await _fetch(query: query);

    return RestaurantStoreModel.fromMap(response[0] as Map<dynamic, dynamic>);
  }
}
