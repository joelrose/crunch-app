part of 'search_bar_cubit.dart';

abstract class StoreBarState extends Equatable {
  const StoreBarState(this.data);

  final List<GetMenusResponseDto> data;

  @override
  List<Object> get props => [data];
}

class SearchBarReload extends StoreBarState {
  const SearchBarReload(List<GetMenusResponseDto> data) : super(data);
}
