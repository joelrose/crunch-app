import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/hermes_service.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._hermesService) : super(DiscoverState()) {
    fetchRestaurants();
  }

  final HermesService _hermesService;

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: DiscoverStatus.loading));

    try {
      final stores = await _hermesService.client.apiMenuGet();

      if (stores.isSuccessful) {
        emit(
          state.copyWith(
            status: DiscoverStatus.success,
            stores: stores.body,
          ),
        );
      } else {
        throw Exception();
      }
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }
}
