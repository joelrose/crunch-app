import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/widgets/search_bar/active_search_widget.dart';
import 'package:pickup/screens/home/widgets/search_bar/recent_search_widget.dart';
import 'package:pickup/screens/home/widgets/search_bar/search_viewmodel.dart';
import 'package:sanity/sanity.dart';

void main() {
  // Unit tests
  final DiscoverySearchBarViewModel searchVM = DiscoverySearchBarViewModel();
  final List<RestaurantOverviewModel> restaurants = [
    RestaurantOverviewModel(
      name: 'First Restaurant',
      image: 'First',
      id: '1',
    ),
    RestaurantOverviewModel(
      name: 'Second Restaurant',
      image: 'Second',
      id: '2',
    ),
    RestaurantOverviewModel(
      name: 'Third Restaurant',
      image: 'Third',
      id: '3',
    ),
  ];
  final List<String> searchHistory = [
    'Flutter',
    'Future',
    'Metro',
    'Burger',
    'Pizza'
  ];
  List<String> filteredSearchHistory =
      searchVM.filterSearchTerms(filter: '', list: searchHistory);
  List<RestaurantOverviewModel> updateFilteredRestaurant({
    required List<RestaurantOverviewModel> restaurants,
    required String filter,
  }) {
    return searchVM.filterRestaurants(restaurants: restaurants, filter: filter);
  }

  group('test filterSearchTerm function', () {
    final List<String> _searchHistory = ['Flutter', 'Future'];

    void filterInput(String input, expectedOutput) {
      searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
        filter: input,
        list: _searchHistory,
      );

      expect(searchVM.filteredSearchHistory, expectedOutput);
    }

    test('filter with matches one term', () {
      filterInput('Flu', ['Flutter']);
    });
    test('filter without a matching term', () {
      filterInput('Java', []);
    });
    test('filter with two matching terms', () {
      filterInput('F', ['Future', 'Flutter']);
    });
  });

  group('test filterRestaurant function', () {
    Iterable<dynamic> mapListName(List<RestaurantOverviewModel>? list) {
      return list!.map((item) => item.name);
    }

    void testFilterRestaurant({
      required String input,
      required expectedOutput,
    }) {
      searchVM.filteredRestaurants =
          searchVM.filterRestaurants(filter: input, restaurants: restaurants);

      expect(
        mapListName(searchVM.filteredRestaurants),
        expectedOutput,
      );
    }

    test('filter which matches one restaurant', () {
      testFilterRestaurant(
        input: 'F',
        expectedOutput: ['First Restaurant'],
      );
    });
    test('filter which matches all restaurants', () {
      testFilterRestaurant(
        input: 'Restaurant',
        expectedOutput: mapListName(restaurants),
      );
    });
    test('filter which matches two restaurants', () {
      testFilterRestaurant(
        input: 'i',
        expectedOutput: ['First Restaurant', 'Third Restaurant'],
      );
    });
  });

  group('test addSearchTerm, deleteSearchTerm and putSearchTermFirst', () {
    void testAddSearchTerm({
      required String input,
      required expectedOutput,
    }) {
      final List<String> testSearchHistory = searchHistory;
      searchVM.addSearchTerm(term: input, list: testSearchHistory);

      expect(testSearchHistory, expectedOutput);
    }

    test('History contains term and puts it first', () {
      testAddSearchTerm(
        input: 'Flutter',
        expectedOutput: ['Future', 'Metro', 'Burger', 'Pizza', 'Flutter'],
      );
    });
    test('Removes last item and adds new item', () {
      testAddSearchTerm(
        input: 'Chilli',
        expectedOutput: ['Metro', 'Burger', 'Pizza', 'Flutter', 'Chilli'],
      );
    });
  });

  // Widget tests
  group('test recentSearchWidget', () {
    final List<String> testSearchHistory = List.from(searchHistory);
    testWidgets('widget without filter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: RecentSearchWidget(
                controller: FloatingSearchBarController(),
                filteredSearchHistory: filteredSearchHistory,
                deleteSearchTerm: searchVM.deleteSearchTerm,
              ),
            ),
          ),
        ),
      );

      final findFirstItem = find.text(testSearchHistory[0]);
      final findSecondItem = find.text(testSearchHistory[1]);

      expect(findFirstItem, findsOneWidget);
      expect(findSecondItem, findsOneWidget);
    });
    testWidgets('widget with filter', (WidgetTester tester) async {
      filteredSearchHistory =
          searchVM.filterSearchTerms(filter: 'flu', list: testSearchHistory);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: RecentSearchWidget(
                controller: FloatingSearchBarController(),
                filteredSearchHistory: filteredSearchHistory,
                deleteSearchTerm: searchVM.deleteSearchTerm,
              ),
            ),
          ),
        ),
      );

      final findFirstItem = find.text(testSearchHistory[0]);
      final findSecondItem = find.text(testSearchHistory[1]);

      expect(findFirstItem, findsOneWidget);
      expect(findSecondItem, findsNothing);
    });
    testWidgets('only find restaurants', (WidgetTester tester) async {
      const String filter = 'First';
      filteredSearchHistory =
          searchVM.filterSearchTerms(filter: filter, list: testSearchHistory);
      final FloatingSearchBarController controller =
          FloatingSearchBarController();

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: ActiveSearchWidget(
                controller: controller,
                filteredSearchHistory: filteredSearchHistory,
                filteredRestaurants: updateFilteredRestaurant(
                  restaurants: restaurants,
                  filter: filter,
                ),
                isRecentSearchVisible: searchVM.isRecentSearchVisible,
                deleteSearchTerm: searchVM.deleteSearchTerm,
                addSearchTerm: searchVM.addSearchTerm,
              ),
            ),
          ),
        ),
      );

      final findFirstItem = find.text(testSearchHistory[0]);
      final findSecondItem = find.text(testSearchHistory[1]);

      expect(findFirstItem, findsNothing);
      expect(findSecondItem, findsNothing);
    });
  });
}
