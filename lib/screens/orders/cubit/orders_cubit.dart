import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._hermesRepository) : super(OrdersState()) {
    fetchOrders();
  }

  final HermesRepository _hermesRepository;

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));

    try {
      final orders = await _hermesRepository.client.ordersGet();

      if (orders.isSuccessful) {
        emit(
          state.copyWith(
            status: OrdersStatus.success,
            orders: orders.body,
          ),
        );
      } else {
        throw Exception();
      }
    } on Exception {
      emit(state.copyWith(status: OrdersStatus.failure));
    }
  }
}
