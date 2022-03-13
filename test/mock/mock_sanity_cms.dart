import 'package:sanity/sanity.dart';

final _mockRestaurantStoreModel = RestaurantStoreModel(
  description: 'description',
  address: 'address',
  googleMapsUrl: 'googleMapsUrl',
  phoneNumber: 'phoneNumber',
  website: 'website',
  name: 'name',
  image: 'image',
  id: 'id',
  menueCategories: [],
);

final _mockRestaurantOverviewModel = RestaurantOverviewModel(
  id: 'id',
  image: 'image',
  name: 'name',
);

class MockSanityCms implements SanityService {
  @override
  Future<RestaurantStoreModel> getRestaurant(String storeId) {
    return Future<RestaurantStoreModel>.value(
      _mockRestaurantStoreModel,
    );
  }

  @override
  Future<List<RestaurantOverviewModel>> getRestaurants() {
    return Future<List<RestaurantOverviewModel>>.value(
      [_mockRestaurantOverviewModel],
    );
  }
}
