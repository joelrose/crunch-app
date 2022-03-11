import 'package:sanity/src/model.dart';
import 'package:sanity/src/queries.dart';
import 'package:sanity/src/sanity_client.dart';

abstract class SanityService {
  Future<List<RestaurantOverviewModel>> getRestaurants();
  Future<RestaurantStoreModel> getRestaurant(String storeId);
}

class SanityCms extends SanityClient implements SanityService {
  SanityCms({
    required String? projectId,
    required String? dataset,
    bool useCdn = true,
  }) : super(dataset: dataset, projectId: projectId, useCdn: useCdn);

  Future<List<RestaurantOverviewModel>> getRestaurants() async {
    final response = await fetch(query: SanityQuery.allAvailableRestaurants);

    return response
        .map<RestaurantOverviewModel>(
          (data) => RestaurantOverviewModel.fromMap(
            data as Map<dynamic, dynamic>,
          ),
        )
        .toList() as List<RestaurantOverviewModel>;
  }

  Future<RestaurantStoreModel> getRestaurant(String storeId) async {
    final query = SanityQuery.singleRestaurant.replaceAll(':id:', storeId);

    final response = await fetch(query: query);

    return RestaurantStoreModel.fromMap(response[0] as Map<dynamic, dynamic>);
  }
}
