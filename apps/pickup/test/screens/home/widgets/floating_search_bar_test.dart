import 'package:flutter_test/flutter_test.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/search_bar/search_viewmodel.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:sanity/sanity.dart';

void main() {
  final List<String> _searchHistory = ['Flutter', 'Future'];
  final DiscoverySearchBarViewModel useCase = DiscoverySearchBarViewModel();
  test('filterSearchTerms function', () {
    final List<String> _searchHistory = ['Flutter', 'Future'];
    final input = ['Flu', 'Java', 'F'];
    final expectedOutput = [
      ['Flutter'],
      [],
      ['Future', 'Flutter']
    ];
    for (var i = 0; i < 3; i++) {
      useCase.filteredSearchHistory = useCase.filterSearchTerms(
        filter: input[i],
        list: _searchHistory,
      );
      expect(useCase.filteredSearchHistory, expectedOutput[i]);
    }
  });
  void filterInput(String input, expectedOutput) {
    useCase.filteredSearchHistory =
        useCase.filterSearchTerms(filter: input, list: _searchHistory);

    expect(useCase.filteredSearchHistory, expectedOutput);
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
      useCase.filteredRestaurants =
          useCase.filterRestaurants(filter: 'n', restaurants: _restaurants);
      expect(useCase.filteredRestaurants, '');
    });
  });
}
