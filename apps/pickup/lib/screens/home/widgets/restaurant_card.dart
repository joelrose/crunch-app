import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/routes.dart';
import 'package:sanity/sanity.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantOverviewModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(storeRoute, arguments: restaurant.id)
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 200,
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
                                restaurant.image,
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
                                      '11 min',
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
                                restaurant.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
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
                                    '4.7',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .merge(
                                          const TextStyle(
                                            color: Color(0xff848484),
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Noodles, pasta, vegan',
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
