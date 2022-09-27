part of 'store_cubit.dart';

enum StoreStatus { initial, loading, success, reload, failure }

extension StoreStatusX on StoreStatus {
  bool get isInitial => this == StoreStatus.initial;
  bool get isLoading => this == StoreStatus.loading;
  bool get isSuccess => this == StoreStatus.success;
  bool get isReload => this == StoreStatus.reload;
  bool get isFailure => this == StoreStatus.failure;
}

class StoreState extends Equatable {
  const StoreState({
    this.status = StoreStatus.initial,
    this.store,
  });

  final StoreStatus status;
  final GetStoreResponse? store;

  StoreState copyWith({
    StoreStatus? status,
    GetStoreResponse? store,
  }) {
    return StoreState(
      status: status ?? this.status,
      store: store ?? this.store,
    );
  }

  @override
  List<Object?> get props => [status, store];
}
