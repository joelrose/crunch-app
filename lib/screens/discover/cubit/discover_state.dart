part of 'discover_cubit.dart';

enum DiscoverStatus { initial, loading, success, failure }

extension DiscoverStatusX on DiscoverStatus {
  bool get isInitial => this == DiscoverStatus.initial;
  bool get isLoading => this == DiscoverStatus.loading;
  bool get isSuccess => this == DiscoverStatus.success;
  bool get isFailure => this == DiscoverStatus.failure;
}

class DiscoverState extends Equatable {
  DiscoverState({
    this.status = DiscoverStatus.initial,
    List<GetStoresOverviewResponse>? stores,
  }) : stores = stores ?? [];

  final DiscoverStatus status;
  final List<GetStoresOverviewResponse> stores;

  DiscoverState copyWith({
    DiscoverStatus? status,
    List<GetStoresOverviewResponse>? stores,
  }) {
    return DiscoverState(
      status: status ?? this.status,
      stores: stores ?? this.stores,
    );
  }

  @override
  List<Object?> get props => [status, stores];
}
