import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_repository/hermes_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._hermesRepository) : super(DiscoverState());

  final HermesRepository _hermesRepository;

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: DiscoverStatus.loading));

    try {
      final stores = await _hermesRepository.client.appV1StoresGet();

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
