import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit(List<GetMenusResponseDto> stores)
      : super(SearchBarState(stores: stores)) {
    initialStores = stores;
  }

  List<GetMenusResponseDto> initialStores = [];

  void search(String query) {
    List<GetMenusResponseDto> restaurants;

    if (query.isEmpty) {
      restaurants = initialStores;
    } else {
      restaurants = initialStores
          .where(
            (restaurant) => restaurant.menu!.menu!
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

  void setStores(List<GetMenusResponseDto> stores) {
    initialStores = stores;
    emit(state.copyWith(stores: stores));
  }
}
