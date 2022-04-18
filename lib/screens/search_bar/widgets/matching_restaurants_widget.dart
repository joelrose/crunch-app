import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MatchingRestaurantsWidget extends StatelessWidget {
  const MatchingRestaurantsWidget({
    Key? key,
    required this.controller,
    required this.filteredRestaurants,
    required this.addSearchTerm,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final List<GetMenusResponseDto> filteredRestaurants;
  final Function addSearchTerm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Matching restaurants',
            style: Theme.of(context).textTheme.headline5!.copyWith(
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
                child: Container(),
                /*RestaurantCard(
                  restaurant: restaurant,
                ),*/
              ),
            );
          },
        ),
      ],
    );
  }
}
