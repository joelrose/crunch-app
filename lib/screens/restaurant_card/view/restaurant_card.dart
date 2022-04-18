import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/screens/store/store.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final GetMenusResponseDto restaurant;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () => {
        Navigator.of(context).pushNamed(
          StoreScreen.route,
          arguments: restaurant.id,
        )
      },
      child: Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 190,
          width: 250,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 123,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                restaurant.menu!.menuImageUrl ?? '',
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
                                    Text(
                                      '${restaurant.averagePickUpTime} min',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .merge(
                                            const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
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
                            children: [
                              Text(
                                restaurant.menu!.menu!,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              if (restaurant.rating != null) ...[
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
                                      restaurant.rating.toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .merge(
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
                          Text(
                            'Noodles, pasta, vegan', //TODO
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
