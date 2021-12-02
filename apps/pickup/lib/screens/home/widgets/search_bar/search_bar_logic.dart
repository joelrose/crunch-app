import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:sanity/sanity.dart';

class SearchUseCase {
  static const historyLenght = 5;
  final List<String> searchHistory = ['Flutter', 'Future'];
  List<String>? filteredSearchHistory;

  final SanityCms cmsClient = locator<SanityCms>();
  RestaurantScreenModel model = locator<RestaurantScreenModel>();

  late final List<RestaurantOverviewModel> restaurants = model.restaurants;

  bool isAppBarVisible = false;
  bool isRecentSearchVisible = true;

  late List<RestaurantOverviewModel>? filteredRestaurants;

  List<String> filterSearchTerms({
    required String filter,
    required List<String> searchHistory,
  }) {
    final List<String> searchHistoryReversed = searchHistory.reversed.toList();
    final List<String> listOfFilteredRecentSearch = searchHistoryReversed
        .where(
          (recentSearch) =>
              recentSearch.toLowerCase().startsWith(filter.toLowerCase()) &&
              recentSearch != filter,
        )
        .toList();

    if (filter != '' && filter.isNotEmpty) {
      return listOfFilteredRecentSearch;
    } else {
      return searchHistoryReversed;
    }
  }

  List<RestaurantOverviewModel> filterRestaurants({
    List<RestaurantOverviewModel> restaurants = const [],
    String filter = '',
  }) {
    if (filter != '' && filter.isNotEmpty) {
      return restaurants
          .where(
            (restaurant) => restaurant.name.toLowerCase().contains(
                  filter.toLowerCase(),
                ),
          )
          .toList();
    } else {
      return restaurants;
    }
  }

  void addSearchTerm({String term = '', String filter = ''}) {
    if (searchHistory.contains(term)) {
      putSearchTermFirst(term: term, filter: filter);
      return;
    }

    searchHistory.add(term);
    if (searchHistory.length > historyLenght) {
      searchHistory.removeRange(0, searchHistory.length - historyLenght);
    }
    filteredSearchHistory =
        filterSearchTerms(filter: filter, searchHistory: searchHistory);
  }

  void deleteSearchTerm({String term = '', String filter = ''}) {
    searchHistory
        .removeWhere((recentSearchedTerms) => recentSearchedTerms == term);
    filteredSearchHistory =
        filterSearchTerms(filter: filter, searchHistory: searchHistory);
  }

  void putSearchTermFirst({String term = '', String filter = ''}) {
    deleteSearchTerm(term: term, filter: filter);
    addSearchTerm(term: term, filter: filter);
  }

  void updateRecentSearchVisibilty() {
    if (filteredSearchHistory!.isNotEmpty) {
      isRecentSearchVisible = true;
    } else {
      isRecentSearchVisible = false;
    }
  }
}
