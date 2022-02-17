import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/screens/restaurant_overview_list/restaurant_overview_list.dart';

class RestaurantDetailView extends StatelessWidget {
  static const route = '/discover/list';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      statusBarStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AlpacaColor.white100Color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  'Restaurants',
                  style: Theme.of(context).textTheme.headline1!.merge(
                        const TextStyle(
                          color: AlpacaColor.blackColor,
                        ),
                      ),
                ),
              ),
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: AlpacaColor.blackColor,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  padding: const EdgeInsets.all(10),
                ),
              )
            ],
          ),
          const Divider(height: 40),
          const Expanded(
            child: RestaurantListView(
              isHorizontal: false,
            ),
          ),
        ],
      ),
    );
  }
}
