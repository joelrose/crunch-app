import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit(List<GetMenusResponseDto> stores)
      : super(SearchBarState(stores: stores)) {
    initialStores = stores;
  }

  List<GetMenusResponseDto> initialStores = [];

  void newQuery(String newQuery) {
    final restaurants = _search(newQuery);

    emit(
      state.copyWith(
        query: newQuery,
        stores: restaurants,
        isRecentSearchVisible: state.searchHistory.isNotEmpty,
      ),
    );
  }

  List<GetMenusResponseDto> _search(String query) {
    final List<GetMenusResponseDto> filteredRestaurant = [];
    for (final restaurant in initialStores) {
      if (_containsQuery(restaurant.menu!.menu!, query)) {
        filteredRestaurant.add(restaurant);
      }
    }

    return filteredRestaurant;
  }

  bool _containsQuery(String restaurantName, String query) {
    return restaurantName.toLowerCase().contains(query.toLowerCase());
  }

  void clearSearch() {
    emit(state.copyWith(query: '', stores: initialStores));
  }

  void addQuery(String query) {
    state.searchHistory.insert(0, query);

    emit(state.copyWith(searchHistory: state.searchHistory));
  }

  void deleteQuery(String query) {
    state.searchHistory.remove(query);

    emit(state.copyWith(searchHistory: state.searchHistory));
  }

  void onFocusChanged() {
    emit(state.copyWith(isAppBarVisible: !state.isAppBarVisible));
  }
}
