import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._hermesRepository) : super(const StoreState());

  final HermesRepository _hermesRepository;

  Future<void> fetchRestaurant(String storeId) async {
    emit(state.copyWith(status: StoreStatus.loading));

    try {
      final menuRequest = await _hermesRepository.client.apiMenusMenuIdGet(
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
