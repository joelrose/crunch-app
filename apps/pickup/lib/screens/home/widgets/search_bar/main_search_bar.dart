import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/base/discover.dart';
import 'package:pickup/screens/home/widgets/discover_nav_bar.dart';
import 'package:pickup/screens/home/widgets/search_bar/search_bar_logic.dart';
import 'search_results_widget.dart';

class DiscoverSearchBar extends StatefulWidget {
  const DiscoverSearchBar({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  _DiscoverSearchBarState createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<DiscoverSearchBar> {
  late Widget child = widget.child;
  SearchUseCase searchVM = SearchUseCase();

  late FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    searchVM.model.fetchRestaurants();
    searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
      filter: '',
      searchHistory: searchVM.searchHistory,
    );
    searchVM.filteredRestaurants = [];
    controller = FloatingSearchBarController();
  }

  void onQueryChanged(String query) {
    setState(() {
      searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
        filter: query,
        searchHistory: searchVM.searchHistory,
      );
      searchVM.filteredRestaurants = searchVM.filterRestaurants(
        filter: query,
        restaurants: searchVM.restaurants,
      );
      searchVM.updateRecentSearchVisibilty();
    });
  }

  void onFocusChanged() {
    setState(() {
      searchVM.isAppBarVisible = !searchVM.isAppBarVisible;
    });
  }

  void onSubmitted(String query) {
    if (query != '') {
      setState(() {
        searchVM.addSearchTerm(term: query, filter: query);
      });
    }
  }

  void deleteSearchTerm({String term = '', String filter = ''}) {
    setState(() {
      searchVM.deleteSearchTerm(term: term, filter: filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: searchVM.isAppBarVisible ? 0 : 50,
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
          return SearchResultsWidget(
            controller: controller,
            filteredSearchHistory: searchVM.filteredSearchHistory!,
            filteredRestaurants: searchVM.filteredRestaurants!,
            isRecentSearchVisible: searchVM.isRecentSearchVisible,
            deleteSearchTerm: deleteSearchTerm,
            addSearchTerm: searchVM.addSearchTerm,
          );
        },
        body: child,
      ),
    );
  }
}
