import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/hermes_service.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._hermesService) : super(const StoreState());

  final HermesService _hermesService;

  Future<void> fetchRestaurant(String storeId) async {
    emit(state.copyWith(status: StoreStatus.loading));

    try {
      final menuRequest = await _hermesService.client.apiMenusMenuIdGet(
        menuId: storeId,
      );

      if (menuRequest.isSuccessful) {
        emit(
          state.copyWith(
            status: StoreStatus.success,
            menu: menuRequest.body,
            checkoutItems: [],
          ),
        );
      } else {
        throw Exception();
      }
    } on Exception {
      emit(state.copyWith(status: StoreStatus.failure));
    }
  }

  void updateCheckoutItems(List<CreateOrderItemDto> newCheckoutItems) {
    // TODO: state does not reload on checkout items, this is a workaround
    emit(
      state.copyWith(
        status:
            state.status.isSuccess ? StoreStatus.reload : StoreStatus.success,
        checkoutItems: newCheckoutItems,
      ),
    );
  }
}
