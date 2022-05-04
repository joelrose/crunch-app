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
    this.menu,
  });

  final StoreStatus status;
  final GetMenuResponseDto? menu;

  StoreState copyWith({
    StoreStatus? status,
    GetMenuResponseDto? menu,
  }) {
    return StoreState(
      status: status ?? this.status,
      menu: menu ?? this.menu,
    );
  }

  @override
  List<Object?> get props => [status, menu];
}
