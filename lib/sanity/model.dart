class RestaurantOverviewModel {
  RestaurantOverviewModel(
      {required this.name, required this.image, required this.id});

  factory RestaurantOverviewModel.fromMap(Map data) {
    return RestaurantOverviewModel(
      name: data['name'] as String,
      image: data['image'] as String,
      id: data['_id'] as String,
    );
  }

  final String name;
  final String image;
  final String id;
}

class RestaurantStoreModel {
  RestaurantStoreModel({
    required this.description,
    required this.address,
    required this.googleMapsUrl,
    required this.phoneNumber,
    required this.website,
    required this.name,
    required this.image,
    required this.id,
  });

  factory RestaurantStoreModel.fromMap(Map data) {
    return RestaurantStoreModel(
      id: data['_id'] as String,
      name: data['name'] as String,
      image: data['image'] as String,
      address: data['address'] as String,
      googleMapsUrl: data['googleMapsUrl'] as String,
      phoneNumber: data['phoneNumber'] as String,
      website: data['website'] as String,
      description: data['description'] as String,
    );
  }

  final String id;
  final String name;
  final String description;
  final String image;
  final String address;
  final String googleMapsUrl;
  final String phoneNumber;
  final String website;
}
