import 'package:sanity/sanity.dart';

class DiscoverySearchBarViewModel {

  dynamic fetchRestaurants() {
    return [];
  }

  List<RestaurantOverviewModel> getRestaurants() {
    return List.empty();
  }

  static const historyLenght = 5;
  final List<String> searchHistory = ['Flutter', 'Future'];
  List<String>? filteredSearchHistory;

  bool isAppBarVisible = false;
  bool isRecentSearchVisible = true;

  late List<RestaurantOverviewModel>? filteredRestaurants;

  String query = '';

  List<String> filterSearchTerms({
    required String filter,
    required List<String> list,
  }) {
    final List<String> listReversed = list.reversed.toList();
    final List<String> listOfFilteredRecentSearch = listReversed
        .where(
          (recentSearch) =>
              recentSearch.toLowerCase().startsWith(filter.toLowerCase()) &&
              recentSearch.toLowerCase() != filter.toLowerCase(),
        )
        .toList();

    if (filter != '' && filter.isNotEmpty) {
      return listOfFilteredRecentSearch;
    } else {
      return listReversed;
    }
  }

  List<RestaurantOverviewModel> filterRestaurants({
    List<RestaurantOverviewModel> restaurants = const [],
    String filter = '',
  }) {
    final List<RestaurantOverviewModel> listOfFilteredRestaurants = restaurants
        .where(
          (restaurant) => restaurant.name.toLowerCase().contains(
                filter.toLowerCase(),
              ),
        )
        .toList();
    if (filter != '' && filter.isNotEmpty) {
      return listOfFilteredRestaurants;
    } else {
      return restaurants;
    }
  }

  void addSearchTerm({required String term, required List<String> list,}) {
    if (list.contains(term)) {
      putSearchTermFirst(
        term: term,
        list: list,
      );
      return;
    }
    list.add(term);
    if (list.length > historyLenght) {
      list.removeRange(0, list.length - historyLenght);
    }
    filteredSearchHistory = filterSearchTerms(filter: query, list: list);
  }

  void deleteSearchTerm({
    required String term,
    required List<String> list,
  }) {
    list.removeWhere((recentSearchedTerms) => recentSearchedTerms == term);
    filteredSearchHistory = filterSearchTerms(filter: query, list: list);
  }

  void putSearchTermFirst({
    required String term,
    required List<String> list,
  }) {
    deleteSearchTerm(
      term: term,
      list: list,
    );
    addSearchTerm(
      term: term,
      list: list,
    );
  }

  void updateRecentSearchVisibilty() {
    if (filteredSearchHistory!.isNotEmpty) {
      isRecentSearchVisible = true;
    } else {
      isRecentSearchVisible = false;
    }
  }
}
