part of 'orders_cubit.dart';

enum OrdersStatus { initial, loading, success, failure }

extension OrdersStatusX on OrdersStatus {
  bool get isInitial => this == OrdersStatus.initial;
  bool get isLoading => this == OrdersStatus.loading;
  bool get isSuccess => this == OrdersStatus.success;
  bool get isFailure => this == OrdersStatus.failure;
}

class OrdersState extends Equatable {
  OrdersState({
    this.status = OrdersStatus.initial,
    List<GetOrdersResponse>? orders,
  }) : orders = orders ?? [];

  final OrdersStatus status;
  final List<GetOrdersResponse> orders;

  OrdersState copyWith({
    OrdersStatus? status,
    List<GetOrdersResponse>? orders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [status, orders];
}
