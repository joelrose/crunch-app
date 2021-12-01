import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/discover_nav_bar.dart';
import 'package:pickup/screens/home/widgets/restaurant_card.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:sanity/sanity.dart';

class SearchUseCase {
  static const historyLenght = 5;

  final List<String> _searchHistory = ['Flutter', 'Future'];

  List<String>? filteredSearchHistory;

  final SanityCms cmsClient = locator<SanityCms>();

  RestaurantScreenModel model = locator<RestaurantScreenModel>();

  late final List<RestaurantOverviewModel> _restaurants = model.restaurants;

  bool isAppBarVisible = false;

  bool isRecentSearchVisible = true;

  List<RestaurantOverviewModel>? filteredRestaurants;

  List<String> filterSearchTerms({
    String filter = '',
    List<String>? searchHistory,
  }) {
    if (filter != '' && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where(
            (recentSearch) =>
                recentSearch.startsWith(filter) && recentSearch != filter,
          )
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  List<RestaurantOverviewModel> filterRestaurants({
    List<RestaurantOverviewModel> restaurants = const [],
    String filter = '',
  }) {
    if (filter != '' && filter.isNotEmpty) {
      return restaurants
          .where(
            (restaurant) => restaurant.name.toLowerCase().contains(
                  filter.toLowerCase(),
                ),
          )
          .toList();
    } else {
      return restaurants;
    }
  }

  void addSearchTerm({String term = '', String filter = ''}) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term: term, filter: filter);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLenght) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLenght);
    }
    filteredSearchHistory =
        filterSearchTerms(filter: filter, searchHistory: _searchHistory);
  }

  void deleteSearchTerm({String term = '', String filter = ''}) {
    _searchHistory
        .removeWhere((recentSearchedTerms) => recentSearchedTerms == term);
    filteredSearchHistory =
        filterSearchTerms(filter: filter, searchHistory: _searchHistory);
  }

  void putSearchTermFirst({String term = '', String filter = ''}) {
    deleteSearchTerm(term: term, filter: filter);
    addSearchTerm(term: term, filter: filter);
  }

  void updateRecentSearchVisibilty() {
    if (filteredSearchHistory!.isNotEmpty) {
      isRecentSearchVisible = true;
    } else {
      isRecentSearchVisible = false;
    }
  }
}

class DiscoverSearchBar extends StatefulWidget {
  const DiscoverSearchBar({Key? key}) : super(key: key);

  @override
  _DiscoverSearchBarState createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<DiscoverSearchBar> {
  SearchUseCase useCase = SearchUseCase();

  late FloatingSearchBarController controller;
  @override
  void initState() {
    useCase.filteredSearchHistory =
        useCase.filterSearchTerms(searchHistory: useCase._searchHistory);
    useCase.model.fetchRestaurants();
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onQueryChanged(String query) {
    setState(() {
      useCase.filteredSearchHistory = useCase.filterSearchTerms(
          filter: query, searchHistory: useCase._searchHistory);
      useCase.filteredRestaurants = useCase.filterRestaurants(
          restaurants: useCase._restaurants, filter: query);
      useCase.updateRecentSearchVisibilty();
    });
  }

  void onFocusChanged() {
    setState(() {
      useCase.isAppBarVisible = !useCase.isAppBarVisible;
    });
  }

  void onSubmitted(String query) {
    if (query != '') {
      setState(() {
        useCase.addSearchTerm(term: query, filter: query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: useCase.isAppBarVisible ? 0 : 50,
          backgroundColor: AlpacaColor.white100Color,
          flexibleSpace: Wrap(children: const [DiscoverNavBar()]),
        ),
      ],
      body: FloatingSearchBar(
        margins: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        insets: const EdgeInsets.symmetric(horizontal: 1),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: AlpacaColor.lightGreyColor80,
        backdropColor: AlpacaColor.white100Color,
        shadowColor: Colors.transparent,
        iconColor: AlpacaColor.darkGreyColor,
        queryStyle: const TextStyle(color: AlpacaColor.blackColor),
        controller: controller,
        transition: CircularFloatingSearchBarTransition(),
        hint: 'Search for food, stores or tags...',
        hintStyle: const TextStyle(
          color: AlpacaColor.darkGreyColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        automaticallyImplyBackButton: false,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        leadingActions: [
          FloatingSearchBarAction.searchToClear(
            color: AlpacaColor.darkGreyColor,
            duration: const Duration(milliseconds: 400),
          ),
        ],
        actions: [
          FloatingSearchBarAction(
            showIfOpened: true,
            showIfClosed: false,
            child: TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AlpacaColor.darkGreyColor),
              ),
              onPressed: () {
                controller.close();
              },
            ),
          )
        ],
        onQueryChanged: (query) => onQueryChanged(query),
        onFocusChanged: (v) => onFocusChanged(),
        onSubmitted: (query) => onSubmitted(query),
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Material(
                color: AlpacaColor.white100Color,
                child: Builder(
                  builder: (context) {
                    if (useCase.filteredSearchHistory!.isEmpty &&
                        controller.query.isEmpty) {
                      return Container(
                        height: 56,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Start searching',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AlpacaColor.darkNavyColor),
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (useCase.isRecentSearchVisible)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Recent searches',
                                  style: TextStyle(
                                    color: AlpacaColor.darkGreyColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: useCase.filteredSearchHistory!
                                        .where(
                                          (recentSearch) =>
                                              recentSearch != controller.query,
                                        )
                                        .map(
                                          (recentSearch) => ListTile(
                                            onTap: () {
                                              controller.query = recentSearch;
                                            },
                                            title: Text(
                                              recentSearch,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color:
                                                    AlpacaColor.darkNavyColor,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(() {
                                                  useCase.deleteSearchTerm(
                                                    term: recentSearch,
                                                    filter: controller.query,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          if (controller.query.isNotEmpty &&
                              useCase.filteredRestaurants!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Matching restaurants',
                                    style: TextStyle(
                                      color: AlpacaColor.darkGreyColor,
                                    ),
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 16),
                                  itemCount:
                                      useCase.filteredRestaurants!.length,
                                  itemBuilder: (context, index) {
                                    final restaurant =
                                        useCase.filteredRestaurants![index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: GestureDetector(
                                        onTap: () => useCase.addSearchTerm(
                                          term: controller.query,
                                          filter: controller.query,
                                        ),
                                        child: RestaurantCard(
                                          restaurant: restaurant,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          if (controller.query.isNotEmpty &&
                              useCase.filteredRestaurants!.isEmpty)
                            const Text(
                              'No matching restaurant found...',
                              style: TextStyle(
                                color: AlpacaColor.darkGreyColor,
                              ),
                            )
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
        body: const DiscoverBody(),
      ),
    );
  }
}
