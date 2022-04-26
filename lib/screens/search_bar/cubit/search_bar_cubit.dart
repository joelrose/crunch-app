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
    List<GetMenusResponseDto> restaurants;

    if (newQuery.isEmpty) {
      restaurants = initialStores;
    } else {
      restaurants = initialStores
          .where(
            (restaurant) => restaurant.menu!.menu!
                .toLowerCase()
                .contains(newQuery.toLowerCase()),
          )
          .toList();
    }

    emit(
      state.copyWith(
        query: newQuery,
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
