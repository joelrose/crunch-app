import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sanity/sanity.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<StoreBarState> {
  SearchBarCubit(this.data) : super(SearchBarReload(data)) {
    init();
  }

  final List<RestaurantOverviewModel> data;

  void init() {}

  List<RestaurantOverviewModel> _restaurants = [];
  List<RestaurantOverviewModel> filteredRestaurant = [];
  late FloatingSearchBarController controller;

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
    for (final restaurant in _restaurants) {
      if (_containsQuery(restaurant.name)) {
        filteredRestaurant.add(restaurant);
      }
    }
  }

  void clearSearch() {
    query = '';
    filteredRestaurant = _restaurants;
  }

  bool _containsQuery(String restaurantName) {
    return restaurantName.toLowerCase().contains(query.toLowerCase());
  }

  void addQuery() {
    searchHistory.insert(0, query);
  }

  void deleteQuery(String query) {
    searchHistory.remove(query);
  }

  void updateRecentSearchVisibilty() {
    isRecentSearchVisible = searchHistory.isNotEmpty;
  }

  // void onQueryChanged(String query) {
  //   searchVM.query = query;
  //   setState(() {
  //     searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
  //       filter: query,
  //       list: searchVM.searchHistory,
  //     );
  //     searchVM.filteredRestaurants = searchVM.filterRestaurants(
  //       filter: query,
  //       restaurants: searchVM.getRestaurants(),
  //     );
  //     searchVM.updateRecentSearchVisibilty();
  //   });
  // }

  // void onFocusChanged() {
  //     searchVM.isAppBarVisible = !searchVM.isAppBarVisible;
  //   });
  // }

  // void onSubmitted(String query) {
  //   if (query != '') {
  //     setState(() {
  //       addSearchTerm(
  //         term: query,
  //         list: searchHistory,
  //       );
  //     });
  //   }
  // }

  // void setRestaurants(List<RestaurantOverviewModel> restaurants) {
  //   data = restaurants;
  // }
}
