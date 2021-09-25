import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/home/models/restaurant_overview_model.dart';
import 'package:alpaca/shared/base_screen.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:flutter/material.dart';

class LeftToRightScrollingList extends StatelessWidget {
  const LeftToRightScrollingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favourite stores',
                  style: TextStyle(
                    fontSize: 22,
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
          ? Container(
              height: 194,
            )
          : Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 0, 0),
              height: 194,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: model.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = model.restaurants[index];
                  return GestureDetector(
                    onTap: () => {
                      Navigator.of(context)
                          .pushNamed(storeRoute, arguments: restaurant.id)
                    },
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        height: 200,
                        width: 250,
                        child: Column(
                          children: [
                            Container(
                              height: 123,
                              width: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    restaurant.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              child: Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
