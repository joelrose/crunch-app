import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/search_bar/cubit/search_viewmodel.dart';
import 'package:pickup/screens/search_bar/widgets/search_bar_view.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late Widget child = widget.child;
  DiscoverySearchBarViewModel searchVM = DiscoverySearchBarViewModel();

  late FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    /*searchVM.fetchRestaurants();
    searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
      filter: '',
      list: searchVM.searchHistory,
    );
    searchVM.filteredRestaurants = [];
    controller = FloatingSearchBarController();*/
  }

  void onQueryChanged(String query) {
    /*searchVM.query = query;
    setState(() {
      searchVM.filteredSearchHistory = searchVM.filterSearchTerms(
        filter: query,
        list: searchVM.searchHistory,
      );
      searchVM.filteredRestaurants = searchVM.filterRestaurants(
        filter: query,
        restaurants: searchVM.getRestaurants(),
      );
      searchVM.updateRecentSearchVisibilty();
    });*/
  }

  void onFocusChanged() {
    setState(() {
      searchVM.isAppBarVisible = !searchVM.isAppBarVisible;
    });
  }

  void onSubmitted(String query) {
    if (query != '') {
      setState(() {
        searchVM.addSearchTerm(
          term: query,
          list: searchVM.searchHistory,
        );
      });
    }
  }

  void deleteSearchTerm({
    String term = '',
  }) {
    /*setState(() {
      searchVM.deleteSearchTerm(
        term: term,
        list: searchVM.searchHistory,
      );
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return SearchBarView(
      controller: controller,
      isAppBarVisible: searchVM.isAppBarVisible,
      isRecentSearchVisible: searchVM.isRecentSearchVisible,
      onQueryChanged: onQueryChanged,
      onFocusChanged: onFocusChanged,
      onSubmitted: onSubmitted,
      deleteSearchTerm: deleteSearchTerm,
      addSearchTerm: searchVM.addSearchTerm,
      filteredSearchHistory: [],
      filteredRestaurants: searchVM.filteredRestaurant,
      child: child,
    );
  }
}
