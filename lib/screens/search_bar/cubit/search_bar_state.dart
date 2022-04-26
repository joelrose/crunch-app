part of 'search_bar_cubit.dart';

class SearchBarState extends Equatable {
  const SearchBarState({
    required this.stores,
    this.isAppBarVisible = false,
    this.isRecentSearchVisible = true,
    this.query = '',
    this.searchHistory = const [],
  });

  final List<GetMenusResponseDto> stores;

  final bool isAppBarVisible;
  final bool isRecentSearchVisible;

  final String query;

  final List<String> searchHistory;

  SearchBarState copyWith({
    List<GetMenusResponseDto>? stores,
    bool? isAppBarVisible,
    bool? isRecentSearchVisible,
    String? query,
    List<String>? searchHistory,
  }) {
    return SearchBarState(
      stores: stores ?? this.stores,
      isAppBarVisible: isAppBarVisible ?? this.isAppBarVisible,
      isRecentSearchVisible:
          isRecentSearchVisible ?? this.isRecentSearchVisible,
      query: query ?? this.query,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }

  @override
  List<Object> get props => [
        stores,
        isAppBarVisible,
        isRecentSearchVisible,
        query,
        searchHistory,
      ];
}
