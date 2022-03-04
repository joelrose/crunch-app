import 'package:sanity/sanity.dart';

class DiscoverySearchBarViewModel {
  DiscoverySearchBarViewModel(List<RestaurantOverviewModel> pRestaurants) {
    restaurants = pRestaurants;
  }

  List<RestaurantOverviewModel> restaurants = [];
  List<RestaurantOverviewModel> filteredRestaurant = [];

  List<String> searchHistory = ['test 1'];

  final bool isAppBarVisible = false;
  bool isRecentSearchVisible = true;

  String query = '';

  void search() {
    filteredRestaurant = [];
    for (final restaurant in restaurants) {
      if (_identicalStart(restaurant.name)) {
        filteredRestaurant.add(restaurant);
      }
    }
  }

  bool _identicalStart(String restaurantName) {
    return restaurantName[query.length].toLowerCase() == query.toLowerCase();
  }

  void deleteSearchTerm(String search) {
    searchHistory.remove(search);
  }

  void updateRecentSearchVisibilty() {
    isRecentSearchVisible = searchHistory.isNotEmpty;
  }
}
