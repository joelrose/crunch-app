import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/hermes_service.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._hermesService) : super(OrdersState());

  final HermesService _hermesService;

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));

    try {
      final orders = await _hermesService.client.apiOrdersGet();

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
