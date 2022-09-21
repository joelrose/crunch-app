part of 'store_information_cubit.dart';

class StoreInformationState extends Equatable {
  const StoreInformationState(this.store);

  final GetStoreResponse store;

  @override
  List<Object> get props => [store];
}
