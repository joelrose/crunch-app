import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sanity/sanity.dart';

import 'active_search_widget.dart';
import 'start_searching_widget.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    Key? key,
    required this.controller,
    required this.filteredSearchHistory,
    required this.filteredRestaurants,
    required this.isRecentSearchVisible,
    required this.deleteSearchTerm,
    required this.addSearchTerm,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final List<String> filteredSearchHistory;
  final List<RestaurantOverviewModel> filteredRestaurants;
  final bool isRecentSearchVisible;
  final deleteSearchTerm;
  final addSearchTerm;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Material(
          color: AlpacaColor.white100Color,
          child: Builder(
            builder: (context) {
              if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                return const NotActiveSearchWidget();
              } else {
                return ActiveSearchWidget(
                  controller: controller,
                  filteredSearchHistory: filteredSearchHistory,
                  filteredRestaurants: filteredRestaurants,
                  isRecentSearchVisible: isRecentSearchVisible,
                  deleteSearchTerm: deleteSearchTerm,
                  addSearchTerm: addSearchTerm,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
