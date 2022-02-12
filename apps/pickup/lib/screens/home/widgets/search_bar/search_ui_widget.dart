import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/widgets/discover_nav_bar.dart';
import 'package:pickup/screens/home/widgets/search_bar/search_results_widget.dart';
import 'package:sanity/sanity.dart';

class SearchBarUI extends StatelessWidget {
  const SearchBarUI({
    Key? key,
    required this.controller,
    required this.isAppBarVisible,
    required this.isRecentSearchVisible,
    required this.onQueryChanged,
    required this.onFocusChanged,
    required this.onSubmitted,
    required this.deleteSearchTerm,
    required this.addSearchTerm,
    required this.filteredSearchHistory,
    required this.filteredRestaurants,
    required this.child,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final bool isAppBarVisible;
  final bool isRecentSearchVisible;
  final Function onQueryChanged;
  final Function onFocusChanged;
  final Function onSubmitted;
  final Function deleteSearchTerm;
  final Function addSearchTerm;
  final List<String> filteredSearchHistory;
  final List<RestaurantOverviewModel> filteredRestaurants;
  final Widget child;
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
      body: Row(
        children: [
          Flexible(
            child: FloatingSearchBar(
              margins: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              insets: const EdgeInsets.symmetric(horizontal: 1),
              borderRadius: BorderRadius.circular(8),
              backgroundColor: AlpacaColor.lightGreyColor80,
              backdropColor: AlpacaColor.white100Color,
              shadowColor: Colors.transparent,
              iconColor: AlpacaColor.darkGreyColor,
              queryStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: AlpacaColor.darkNavyColor,
              ),
              controller: controller,
              transition: CircularFloatingSearchBarTransition(),
              hint: 'Search for food, store, or tags',
              hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AlpacaColor.greyColor80,
              ),
              automaticallyImplyBackButton: false,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              leadingActions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: AlpacaColor.darkGreyColor,
                  ),
                ),
              ],
              actions: [
                if (controller.query.isNotEmpty)
                  FloatingSearchBarAction(
                    showIfOpened: true,
                    showIfClosed: false,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/close.svg',
                        color: AlpacaColor.darkGreyColor,
                      ),
                      onPressed: () {
                        controller.query = '';
                      },
                    ),
                  ),
                FloatingSearchBarAction(
                  showIfOpened: true,
                  showIfClosed: false,
                  child: TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AlpacaColor.darkGreyColor,
                          ),
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
                  filteredSearchHistory: filteredSearchHistory,
                  filteredRestaurants: filteredRestaurants,
                  isRecentSearchVisible: isRecentSearchVisible,
                  deleteSearchTerm: deleteSearchTerm,
                  addSearchTerm: addSearchTerm,
                );
              },
              body: child,
            ),
          ),
        ],
      ),
    );
  }
}
