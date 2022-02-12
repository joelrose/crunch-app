import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickup/screens/home/widgets/favourites/restaurant_card_widget.dart';
import 'package:sanity/sanity.dart';

class MatchingRestaurantsWidget extends StatelessWidget {
  const MatchingRestaurantsWidget({
    Key? key,
    required this.controller,
    required this.filteredRestaurants,
    required this.addSearchTerm,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final List<RestaurantOverviewModel> filteredRestaurants;
  final Function addSearchTerm;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount: filteredRestaurants.length,
          itemBuilder: (context, index) {
            final restaurant = filteredRestaurants[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () => addSearchTerm(
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
    );
  }
}
