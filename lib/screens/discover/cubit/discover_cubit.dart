import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/sanity.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._sanityClient) : super(DiscoverState()) {
    fetchRestaurants();
  }

  final SanityCms _sanityClient;

  Future<void> fetchRestaurants() async {
    emit(state.copyWith(status: DiscoverStatus.loading));

    try {
      final restaurants = await _sanityClient.getRestaurants();

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          restaurants: restaurants,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }
}
