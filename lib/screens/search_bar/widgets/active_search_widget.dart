import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/search_bar/widgets/matching_restaurants_widget.dart';
import 'package:pickup/screens/search_bar/widgets/recent_search_widget.dart';
import 'package:sanity/sanity.dart';
import 'package:pickup/l10n/l10n.dart';

class ActiveSearchWidget extends StatelessWidget {
  const ActiveSearchWidget({
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
  final Function deleteSearchTerm;
  final Function addSearchTerm;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRecentSearchVisible)
          RecentSearchWidget(
            controller: controller,
            filteredSearchHistory: filteredSearchHistory,
            deleteSearchTerm: deleteSearchTerm,
          ),
        if (controller.query.isNotEmpty && filteredRestaurants.isNotEmpty)
          MatchingRestaurantsWidget(
            controller: controller,
            filteredRestaurants: filteredRestaurants,
            addSearchTerm: addSearchTerm,
          ),
        if (controller.query.isNotEmpty && filteredRestaurants.isEmpty)
          Text(
            context.l10n.noRestaurantsFound,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AlpacaColor.darkGreyColor,
                ),
          )
      ],
    );
  }
}
