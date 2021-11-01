String _string(dynamic s) => (s ?? '') as String;

class RestaurantOverviewModel {
  RestaurantOverviewModel(
      {required this.name, required this.image, required this.id});

  factory RestaurantOverviewModel.fromMap(Map data) {
    return RestaurantOverviewModel(
      name: _string(data['name']),
      image: _string(data['image']),
      id: _string(data['_id']),
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
    required this.menueCategories,
  });

  factory RestaurantStoreModel.fromMap(Map data) {
    return RestaurantStoreModel(
      id: _string(data['_id']),
      name: _string(data['name']),
      image: _string(data['image']),
      address: _string(data['address']),
      googleMapsUrl: _string(data['googleMapsUrl']),
      phoneNumber: _string(data['phoneNumber']),
      website: _string(data['website']),
      description: _string(data['description']),
      menueCategories: (data['menuCateogries'] as List)
          .map(
            (v) => RestaurantMenueCategoryModel.fromMap(
              v as Map<dynamic, dynamic>,
            ),
          )
          .toList(),
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
  final List<RestaurantMenueCategoryModel> menueCategories;
}

class RestaurantMenueCategoryModel {
  RestaurantMenueCategoryModel({
    required this.title,
    required this.menueItems,
  });

  factory RestaurantMenueCategoryModel.fromMap(Map data) {
    return RestaurantMenueCategoryModel(
      title: LocaleString.fromMap(data['title'] as Map<dynamic, dynamic>),
      menueItems: (data['menuItems'] as List)
          .map(
            (v) => RestaurantMenueItemModel.fromMap(
              v as Map<dynamic, dynamic>,
            ),
          )
          .toList(),
    );
  }

  final LocaleString title;
  final List<RestaurantMenueItemModel> menueItems;
}

class RestaurantMenueItemModel {
  RestaurantMenueItemModel({
    required this.id,
    required this.title,
    required this.price,
  });

  factory RestaurantMenueItemModel.fromMap(Map data) {
    return RestaurantMenueItemModel(
      id: _string(data['_key']),
      title: LocaleString.fromMap(data['title'] as Map<dynamic, dynamic>),
      price: data['price'] as num,
    );
  }

  final String id;
  final LocaleString title;
  final num price;
}

class LocaleString {
  LocaleString({
    required this.german,
    required this.english,
  });

  factory LocaleString.fromMap(Map data) {
    return LocaleString(
      german: _string(data['de']),
      english: _string(data['en']),
    );
  }

  final String german;
  final String english;
}