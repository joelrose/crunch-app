part of 'store_information_cubit.dart';

class StoreInformationState extends Equatable {
  const StoreInformationState(this.menu);

  final GetMenuResponseDto menu;

  @override
  List<Object> get props => [menu];
}
