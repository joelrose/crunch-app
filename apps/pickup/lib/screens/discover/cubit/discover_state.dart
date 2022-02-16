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
    List<RestaurantOverviewModel>? restaurants,
  }) : restaurants = restaurants ?? [];

  final DiscoverStatus status;
  final List<RestaurantOverviewModel> restaurants;

  DiscoverState copyWith(
      {DiscoverStatus? status, List<RestaurantOverviewModel>? restaurants}) {
    return DiscoverState(
      status: status ?? this.status,
      restaurants: restaurants ?? [],
    );
  }

  @override
  List<Object?> get props => [status, restaurants];
}
