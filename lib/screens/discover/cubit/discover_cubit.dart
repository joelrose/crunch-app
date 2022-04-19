import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._hermesRepository) : super(DiscoverState()) {
    fetchRestaurants();
  }

  final HermesRepository _hermesRepository;

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: DiscoverStatus.loading));

    try {
      final stores = await _hermesRepository.client.apiMenusGet();

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
