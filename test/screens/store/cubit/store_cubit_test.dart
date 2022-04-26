import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';

import '../../../mock/mock_hermes_service.dart';

void main() {
  late HermesRepository hermesService;

  group('StoreCubit', () {
    blocTest<StoreCubit, StoreState>(
      'emits discover when nothing is called',
      setUp: () {
        hermesService = MockHermesService('[]', 200);
      },
      build: () => StoreCubit(hermesService),
      verify: (b) => b.state.status.isSuccess,
    );

    blocTest<StoreCubit, StoreState>(
      'emits failure when statuscode is not succesfull',
      setUp: () {
        hermesService = MockHermesService('[]', 404);
      },
      build: () => StoreCubit(hermesService),
      verify: (b) => b.state.status.isFailure,
    );

    blocTest<StoreCubit, StoreState>(
      'emits failure when exception is thrown',
      setUp: () {
        hermesService = MockHermesService('[]', 200, throwException: true);
      },
      build: () => StoreCubit(hermesService),
      verify: (b) => b.state.status.isFailure,
    );

    blocTest<StoreCubit, StoreState>(
      'emits success',
      setUp: () {
        hermesService = MockHermesService('{}', 200);
      },
      build: () => StoreCubit(hermesService),
      act: (bloc) async {
        bloc.fetchRestaurant('test');
      },
      verify: (b) => b.state.status.isSuccess,
    );
  });
}
