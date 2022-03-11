class SanityQuery {
  static const String allAvailableRestaurants = '''
  *[_type == 'restaurant' && enabled == true] {
    _id,
    name,
    "image": image.asset->url
  }
  ''';

  static const String singleRestaurant = '''
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
}
