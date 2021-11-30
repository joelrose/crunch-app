import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/floating_search_bar.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:sanity/sanity.dart';

void main() {
  final List<String> _searchHistory = ['Flutter', 'Future'];
  test('filterSearchTerms function', () {
    final List<String> _searchHistory = ['Flutter', 'Future'];
    final input = ['Flu', 'Java', 'F'];
    final expectedOutput = [
      ['Flutter'],
      [],
      ['Future', 'Flutter']
    ];
    for (var i = 0; i < 3; i++) {
      filteredSearchHistory =
          filterSearchTerms(filter: input[i], searchHistory: _searchHistory);
      expect(filteredSearchHistory, expectedOutput[i]);
    }
  });
  void filterInput(String input, expectedOutput) {
    filteredSearchHistory =
        filterSearchTerms(filter: input, searchHistory: _searchHistory);

    expect(filteredSearchHistory, expectedOutput);
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

  group('filterRestaurant function', () {
    final SanityCms cmsClient = locator<SanityCms>();
    RestaurantScreenModel model = locator<RestaurantScreenModel>();
    late final List<RestaurantOverviewModel> _restaurants = model.restaurants;
    test('description', () {
      filteredRestaurants =
          filterRestaurants(filter: 'n', restaurants: _restaurants);
      expect(filteredRestaurants, '');
    });
  });
}