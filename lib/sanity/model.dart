class RestaurantModel {
  RestaurantModel({required this.name, required this.image, required this.id});

  factory RestaurantModel.fromMap(Map data) {
    return RestaurantModel(
      name: data['name'] as String,
      image: data['image'] as String,
      id: data['_id'] as String,
    );
  }

  final String name;
  final String image;
  final String id;
}
