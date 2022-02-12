import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/home/models/restaurant_overview_model.dart';
import 'package:pickup/screens/home/widgets/favourites/restaurant_card_widget.dart';
import 'package:pickup/shared/base_screen.dart';
import 'package:pickup/shared/viewstate.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class FavouritesDetail extends StatelessWidget {
  static const route = '/favorites';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      statusBarStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                color: AlpacaColor.blackColor,
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                padding: const EdgeInsets.all(10),
              ),
              Text(
                'Restaurants',
                style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(
                        color: AlpacaColor.blackColor,
                      ),
                    ),
              ),
            ],
          ),
          const Divider(height: 40),
          const Expanded(
            child: RestaurantOverviewListVertical(),
          ),
        ],
      ),
    );
  }
}

class RestaurantOverviewListVertical extends StatefulWidget {
  const RestaurantOverviewListVertical({Key? key}) : super(key: key);

  @override
  _RestaurantOverviewListVerticalState createState() =>
      _RestaurantOverviewListVerticalState();
}

class _RestaurantOverviewListVerticalState
    extends State<RestaurantOverviewListVertical> {
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
          : SizedBox(
              height: 194,
              child: ListView.separated(
                clipBehavior: Clip.none,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 25),
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
