import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/restaurant_card.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/viewstate.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class LeftToRightScrollingList extends StatelessWidget {
  const LeftToRightScrollingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Restaurants',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    fontWeight: FontWeight.w700,
                    color: AlpacaColor.darkNavyColor,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AlpacaColor.greyColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AlpacaColor.darkNavyColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(height: 18),
          const RestaurantOverviewList(),
        ],
      ),
    );
  }
}

class RestaurantOverviewList extends StatefulWidget {
  const RestaurantOverviewList({Key? key}) : super(key: key);

  @override
  _RestaurantOverviewListState createState() => _RestaurantOverviewListState();
}

class _RestaurantOverviewListState extends State<RestaurantOverviewList> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<RestaurantScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurants();
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? SkeletonLoader(
              builder: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 194,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: const SizedBox(
                        height: 200,
                        width: 250,
                      ),
                    );
                  },
                ),
              ),
              highlightColor: AlpacaColor.primary100,
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 194,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: model.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = model.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              ),
            ),
    );
  }
}
