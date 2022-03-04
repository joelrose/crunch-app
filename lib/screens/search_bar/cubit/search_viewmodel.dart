import 'dart:html';

import 'package:sanity/sanity.dart';

class DiscoverySearchBarViewModel {
  DiscoverySearchBarViewModel(List<RestaurantOverviewModel> pRestaurants) {
    restaurants = pRestaurants;
  }

  List<RestaurantOverviewModel> restaurants = [];
  List<RestaurantOverviewModel> filteredRestaurant = [];

  List<String> searchHistory = ['test 1'];

  bool isAppBarVisible = false;
  bool isRecentSearchVisible = true;

  String query = '';

  void newQuery(String newQuery) {
    query = newQuery;
    search();
    updateRecentSearchVisibilty();
  }

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

  void addQuerry(String querry) {
    searchHistory.insert(0, querry);
  }

  void deleteQuerry(String querry) {
    searchHistory.remove(querry);
  }

  void updateRecentSearchVisibilty() {
    isRecentSearchVisible = searchHistory.isNotEmpty;
  }
}
