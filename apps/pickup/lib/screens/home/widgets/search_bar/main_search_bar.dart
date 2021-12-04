import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'search_bar_logic.dart';
import 'search_ui_widget.dart';

class DiscoverSearchBar extends StatefulWidget {
  const DiscoverSearchBar({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  _DiscoverSearchBarState createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<DiscoverSearchBar> {
  late Widget child = widget.child;
  DiscoverySearchBarViewModel searchVM = DiscoverySearchBarViewModel();

  late FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    searchVM.fetchRestaurants();
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
        restaurants: searchVM.getRestaurants(),
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
    return SearchBarUI(
      controller: controller,
      isAppBarVisible: searchVM.isAppBarVisible,
      isRecentSearchVisible: searchVM.isRecentSearchVisible,
      onQueryChanged: onQueryChanged,
      onFocusChanged: onFocusChanged,
      onSubmitted: onSubmitted,
      deleteSearchTerm: deleteSearchTerm,
      addSearchTerm: searchVM.addSearchTerm,
      filteredSearchHistory: searchVM.filteredSearchHistory!,
      filteredRestaurants: searchVM.filteredRestaurants!,
      child: child,
    );
  }
}
