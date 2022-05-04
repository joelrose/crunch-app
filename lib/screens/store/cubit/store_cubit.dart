import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(
    HermesRepository hermesRepository,
  )   : _hermesRepository = hermesRepository,
        super(const StoreState());

  final HermesRepository _hermesRepository;

  Future<void> fetchRestaurant(String storeId) async {
    emit(state.copyWith(status: StoreStatus.loading));

    try {
      final menu = await _hermesRepository.apiMenusMenuIdGet(
        storeId: storeId,
      );

      emit(
        state.copyWith(
          status: StoreStatus.success,
          menu: menu,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: StoreStatus.failure));
    }
  }
}
