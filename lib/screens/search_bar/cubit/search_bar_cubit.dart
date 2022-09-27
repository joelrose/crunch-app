import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit(List<GetStoresOverviewResponse> stores)
      : super(SearchBarState(stores: stores)) {
    initialStores = stores;
  }

  List<GetStoresOverviewResponse> initialStores = [];

  void search(String query) {
    List<GetStoresOverviewResponse> restaurants;

    if (query.isEmpty) {
      restaurants = initialStores;
    } else {
      restaurants = initialStores
          .where(
            (restaurant) => restaurant.name!
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();
    }

    emit(
      state.copyWith(
        query: query,
        stores: restaurants,
      ),
    );
  }

  void clearSearch() {
    emit(state.copyWith(query: '', stores: initialStores));
  }

  void onFocusChanged() {
    emit(state.copyWith(isAppBarVisible: !state.isAppBarVisible));
  }

  void setStores(List<GetStoresOverviewResponse> stores) {
    initialStores = stores;
    emit(state.copyWith(stores: stores));
  }
}
