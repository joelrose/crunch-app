part of 'search_bar_cubit.dart';

class SearchBarState extends Equatable {
  const SearchBarState({
    required this.stores,
    this.isAppBarVisible = false,
    this.query = '',
  });

  final List<GetStoresOverviewResponse> stores;

  final bool isAppBarVisible;

  final String query;

  SearchBarState copyWith({
    List<GetStoresOverviewResponse>? stores,
    bool? isAppBarVisible,
    String? query,
  }) {
    return SearchBarState(
      stores: stores ?? this.stores,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [
        stores,
        isAppBarVisible,
        query,
      ];
}
