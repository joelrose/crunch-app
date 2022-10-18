import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:pickup/screens/store/cubit/store_cubit.dart';

class MockHermesRepository extends Mock implements HermesRepository {}

void main() {
  late MockHermesRepository hermesService;

  group('StoreCubit', () {
    setUpAll(() {
      hermesService = MockHermesRepository();
    });

    StoreCubit buildCubit() {
      return StoreCubit(hermesService);
    }

    test('has correct initial state', () {
      expect(
        buildCubit().state,
        equals(const StoreState()),
      );
    });

    blocTest<StoreCubit, StoreState>(
      'emits failure when expection is thrown',
      setUp: () {
        when(
          () => hermesService.client.appV1StoreIdGet(
            id: any(named: 'storeId'),
          ),
        ).thenThrow(Exception());
      },
      build: () => StoreCubit(hermesService),
      act: (c) => c.fetchRestaurant(''),
      expect: () => [
        const StoreState(status: StoreStatus.loading),
        const StoreState(status: StoreStatus.failure),
      ],
    );

    /*blocTest<StoreCubit, StoreState>(
      'emits success when response is successful',
      setUp: () {
        when(
          () => hermesService.client.storeIdGet(
            id: any(named: 'storeId'),
          ),
        ).thenAnswer((_) => Future.value(GetStoreResponse()));
      },
      act: (c) => c.fetchRestaurant(''),
      build: () => StoreCubit(hermesService),
      expect: () => [
        const StoreState(status: StoreStatus.loading),
        StoreState(status: StoreStatus.success, store: GetStoreResponse()),
      ],
    );*/
  });
}
