import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/store/store.dart';
import 'package:sanity/sanity.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantOverviewModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () => {
        Navigator.of(context)
            .pushNamed(StoreScreen.route, arguments: restaurant.id)
      },
      child:
       Container(
        width: 235,
        decoration: BoxDecoration(
          color: AlpacaColor.white100Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 75,
              color: Color.fromARGB(25, 0, 0, 0),
            )
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 113,
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
                        top: 11,
                        right: 11,
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/location.svg',
                                      color: AlpacaColor.white100Color,
                                    ),
                                  ),
                                  Text(
                                    '11 min',
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                restaurant.name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: AlpacaColor.blackColor,
                                    ),
                              ),
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
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Text(
                                        '4.7',
                                        textAlign: TextAlign.center,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/starRating.svg',
                                      color: AlpacaColor.goldColor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Noodles, pasta, vegan',
                          style: Theme.of(context).textTheme.caption,
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
    );
  }
}
