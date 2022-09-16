import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';

void main() {
  group('SearchBarCubit', () {
    final store1 = GetStoresOverviewResponse(
      id: 'id',
      averageReview: 3,
      reviewCount: 12,
      averagePickupTime:12,
      name: 'test',
    );

    final store2 = GetStoresOverviewResponse(
      id: 'id',
      averageReview: 3,
      reviewCount: 12,
      averagePickupTime:12,
      name: 'hello',
    );

    final stores = [
      store1,
      store2,
    ];

    test('initial state is correct', () {
      expect(
        SearchBarCubit([]).state,
        equals(
          const SearchBarState(
            stores: [],
          ),
        ),
      );
    });

    group('.newQuery', () {
      blocTest<SearchBarCubit, SearchBarState>(
        'emits all stores when query is empty',
        build: () => SearchBarCubit(stores),
        act: (cubit) => cubit.search(''),
        expect: () => [
          SearchBarState(
            stores: stores,
          ),
        ],
      );

      blocTest<SearchBarCubit, SearchBarState>(
        'emits queried stores when full keyword is given',
        build: () => SearchBarCubit(stores),
        act: (cubit) => cubit.search('test'),
        expect: () => [
          SearchBarState(
            stores: [store1],
            query: 'test',
          ),
        ],
      );

      blocTest<SearchBarCubit, SearchBarState>(
        'emits queried stores when partial keyword is given',
        build: () => SearchBarCubit(stores),
        act: (cubit) => cubit.search('hel'),
        expect: () => [
          SearchBarState(
            stores: [store2],
            query: 'hel',
          ),
        ],
      );
    });

    blocTest<SearchBarCubit, SearchBarState>(
      '.clearSearch emits empty query & resets stores',
      build: () => SearchBarCubit(stores),
      act: (cubit) {
        cubit.search(store1.name!);
        cubit.clearSearch();
      },
      expect: () => [
        SearchBarState(
          stores: [store1],
          query: store1.name!,
        ),
        SearchBarState(
          stores: stores,
        ),
      ],
    );

    blocTest<SearchBarCubit, SearchBarState>(
      '.onFocusChanged emits isAppBarVisible true',
      build: () => SearchBarCubit([]),
      act: (cubit) => cubit.onFocusChanged(),
      expect: () => [
        const SearchBarState(
          stores: [],
          isAppBarVisible: true,
        ),
      ],
    );

    blocTest<SearchBarCubit, SearchBarState>(
      '.setStores emits stores',
      build: () => SearchBarCubit([]),
      act: (cubit) => cubit.setStores(stores),
      expect: () => [
        SearchBarState(
          stores: stores,
        ),
      ],
      verify: (cubit) => expect(cubit.initialStores, equals(stores)),
    );
  });
}
