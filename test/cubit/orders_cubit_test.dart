import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/orders/cubit/orders_cubit.dart';

void main() {
  late HermesRepository hermesService;

  group('OrdersCubit', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits discover when nothing is called',
      setUp: () {
        hermesService = MockHermesService('[]', 200);
      },
      build: () => OrdersCubit(hermesService),
      verify: (b) => b.state.status.isSuccess,
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits failure when statuscode is not succesfull',
      setUp: () {
        hermesService = MockHermesService('[]', 404);
      },
      build: () => OrdersCubit(hermesService),
      verify: (b) => b.state.status.isFailure,
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits failure when exception is thrown',
      setUp: () {
        hermesService = MockHermesService('[]', 200, throwException: true);
      },
      build: () => OrdersCubit(hermesService),
      verify: (b) => b.state.status.isFailure,
    );
  });
}
