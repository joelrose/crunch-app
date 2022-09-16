import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hermes_repository/hermes_repository.dart';
import 'package:pickup/screens/store/store.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final GetStoresOverviewResponse restaurant;

  @override
  Widget build(BuildContext context) {
    if (true) { //restaurant.isOpen!) {
      return Bounceable(
        key: const Key('restaurant_card'),
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pushNamed(
            StorePage.route,
            arguments: restaurant.id,
          );
        },
        child: _content(context),
      );
    } else {
      return _content(context);
    }
  }

  Widget _content(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 220,
        width: 250,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  _stack(context),
                  _overlay(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stack(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 123,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                restaurant.imageUrl ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                height: 26,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: AlpacaColor.white100Color,
                      ),
                    ),
                    if (true) ...[ // restaurant.isOpen!) ...[
                      Text(
                        '${restaurant.averagePickupTime} min',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.subtitle1!.merge(
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ),
                    ] else ...[
                      Text(
                        'Closed',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.subtitle1!.merge(
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _overlay(BuildContext context) {
    final textDecoration =
        true ? null : TextDecoration.lineThrough; // restaurant.isOpen!

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  restaurant.name!,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        decoration: textDecoration,
                      ),
                ),
              ),
              if (restaurant.averageReview != null) ...[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(
                      color: const Color(0xffeff1f1),
                      width: 0.50,
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: SizedBox(
                    width: 24,
                    height: 12,
                    child: Text(
                      restaurant.averageReview.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2!.merge(
                            const TextStyle(
                              color: AlpacaColor.darkGreyColor,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                    ),
                  ),
                )
              ]
            ],
          ),
          /*Text(
                            'Noodles, pasta, vegan', //TODO
                            style: Theme.of(context).textTheme.subtitle2,
                          )*/
        ],
      ),
    );
  }
}
