import 'package:bloc_test/bloc_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('SearchBarCubit', () {
    final store1 = GetMenusResponseDto(
      id: 'id',
      rating: 3,
      reviewCount: '12',
      averagePickUpTime: '12',
      menu: DeliverectMenusDto(
        menu: 'test',
      ),
    );

    final store2 = GetMenusResponseDto(
      id: 'id',
      rating: 3,
      reviewCount: '12',
      averagePickUpTime: '12',
      menu: DeliverectMenusDto(
        menu: 'hello',
      ),
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
        cubit.search(store1.menu!.menu!);
        cubit.clearSearch();
      },
      expect: () => [
        SearchBarState(
          stores: [store1],
          query: store1.menu!.menu!,
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
