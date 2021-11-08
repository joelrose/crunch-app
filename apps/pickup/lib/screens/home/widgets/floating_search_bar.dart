import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/discover_nav_bar.dart';
import 'package:pickup/screens/home/widgets/restaurant_card.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/viewstate.dart';

class DiscoverSearchBar extends StatefulWidget {
  const DiscoverSearchBar({Key? key}) : super(key: key);

  @override
  _DiscoverSearchBarState createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<DiscoverSearchBar> {
  static const historyLenght = 10;

  final List<String> _searchHistory = ['Flutter', 'Future'];

  List<String>? filteredSearchHistory;

  String? selectedTerm;

  bool isAppBarVisible = false;

  bool isRecentSearchVisible = true;

  bool isQueryEmpty = true;

  List<String> filterSearchTerms({
    String filter = '',
  }) {
    if (filteredSearchHistory != null) {
      updateRecentSearchVisibilty();
    }
    if (filter != '' && filter.isNotEmpty) {
      isQueryEmpty = false;
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      isQueryEmpty = true;
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLenght) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLenght);
    }

    filteredSearchHistory = filterSearchTerms();
  }

  void deleteSearchTerm(String term) {
    _searchHistory
        .removeWhere((recentSearchedTerms) => recentSearchedTerms == term);
    filteredSearchHistory = filterSearchTerms();
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void updateRecentSearchVisibilty() {
    if (filteredSearchHistory!.isNotEmpty &&
        _searchHistory
            .where((term) => term == controller.query)
            .toList()
            .isEmpty) {
      isRecentSearchVisible = true;
    } else {
      isRecentSearchVisible = false;
    }
  }

  void filterRestaurants(model) {
    print(model);
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: isAppBarVisible ? 0 : 50,
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
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onFocusChanged: (v) {
          setState(() {
            isAppBarVisible = !isAppBarVisible;
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: AlpacaColor.white100Color,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory!.isEmpty &&
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
                        if (isRecentSearchVisible)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recent searches',
                                style:
                                    TextStyle(color: AlpacaColor.darkGreyColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: filteredSearchHistory!
                                      .map(
                                        (term) => ListTile(
                                          onTap: () {
                                            controller.query = term;
                                          },
                                          title: Text(
                                            term,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AlpacaColor.darkNavyColor,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.clear),
                                            onPressed: () {
                                              setState(() {
                                                deleteSearchTerm(term);
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
                        if (!isQueryEmpty)
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
                              BaseScreen<RestaurantScreenModel>(
                                onModelReady: (model) {
                                  model.fetchRestaurants();
                                },
                                builder: (context, model, child) {
                                  if (model.state == ViewState.busy) {
                                    return Container();
                                  } else {
                                    var restaurants = model.restaurants;
                                    filterRestaurants(restaurants);
                                    restaurants = restaurants
                                        .where((restaurant) => restaurant.name
                                            .startsWith(controller.query))
                                        .toList();
                                    print(restaurants.map((e) => e.name));
                                    return ListView.separated(
                                      clipBehavior: Clip.none,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 16),
                                      itemCount: restaurants.length,
                                      itemBuilder: (context, index) {
                                        final restaurant = restaurants[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: RestaurantCard(
                                            restaurant: restaurant,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                      ],
                    );
                  }
                },
              ),
            ),
          );
        },
        body: const DiscoverBody(),
      ),
    );
  }
}
