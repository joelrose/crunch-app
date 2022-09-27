import 'package:flutter_test/flutter_test.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';

void main() {
  group('SearchBarState', () {
    final menu = [
      GetStoresOverviewResponse(
        id: 'id',
        averageReview: 3,
        reviewCount: 12,
        averagePickupTime: 12,
        name: '',
      ),
    ];
    test('supports value comparison', () {
      expect(
        SearchBarState(
          stores: menu,
          query: 'query',
          isAppBarVisible: true,
        ),
        SearchBarState(
          stores: menu,
          query: 'query',
          isAppBarVisible: true,
        ),
      );
    });

    group('.copyWith', () {
      test('overrides all fields', () {
        final state = SearchBarState(
          stores: menu,
          query: 'query',
          isAppBarVisible: true,
        );

        expect(
          state.copyWith(isAppBarVisible: false, query: '', stores: []),
          const SearchBarState(
            stores: [],
          ),
        );
      });

      test('leaves fields as before', () {
        final state = SearchBarState(
          stores: menu,
          query: 'query',
          isAppBarVisible: true,
        );

        expect(
          state.copyWith(),
          state,
        );
      });
    });
  });
}
