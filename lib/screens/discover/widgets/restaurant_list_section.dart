import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/restaurant_detail/restaurant_detail.dart';
import 'package:pickup/screens/restaurant_overview_list/restaurant_overview_list.dart';

class RestaurantListSection extends StatelessWidget {
  const RestaurantListSection({Key? key}) : super(key: key);

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
                  style: Theme.of(context).textTheme.headline2,
                ),
                Bounceable(
                  duration: const Duration(milliseconds: 100),
                  onTap: () => Navigator.of(context)
                      .pushNamed(RestaurantDetailView.route),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AlpacaColor.lightGreyColor90),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'View all',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: AlpacaColor.darkNavyColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 18),
          const RestaurantListView(),
        ],
      ),
    );
  }
}
