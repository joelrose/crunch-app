import 'dart:math';
import 'dart:ui';

import 'package:alpaca/global.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
import 'package:alpaca/shared/base_screen.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/shared/buttons.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key, required this.storeId}) : super(key: key);

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(storeId);
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? Container(color: AlpacaColor.white100Color)
          : PageWrapper(
              padding: EdgeInsets.zero,
              backgroundColor: AlpacaColor.white100Color,
              statusBarStyle: SystemUiOverlayStyle.dark,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                          model.restaurant.image,
                        ).image,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: IconButton(
                                onPressed: () {},
                                color: AlpacaColor.white100Color,
                                icon: const Icon(Icons.star_border_outlined),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: IconButton(
                                onPressed: () {},
                                color: AlpacaColor.white100Color,
                                icon: const Icon(Icons.info_outline),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StoreOverview(
                    name: model.restaurant.name,
                    rating: '4.2',
                    walkingDistance: '200',
                    walkingTime: '11',
                    googleMaps: model.restaurant.googleMapsUrl,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Store information',
                                style: TextStyle(
                                  color: Color(0xff2b2d42),
                                  fontSize: 18,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        const StoreInformationItem(
                          icon: Icons.access_time,
                          title: 'Opening times',
                          description: '11:00-22:00',
                        ),
                        StoreInformationItem(
                          icon: Icons.phone_outlined,
                          title: 'Contact number',
                          description: model.restaurant.phoneNumber,
                        ),
                        StoreInformationItem(
                          icon: Icons.location_on_outlined,
                          title: 'Store address',
                          description: model.restaurant.address,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Menu',
                                style: TextStyle(
                                  color: Color(0xff2b2d42),
                                  fontSize: 18,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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

class StoreInformationItem extends StatelessWidget {
  const StoreInformationItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AlpacaColor.primary80),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff7d8489),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xff2b2d42),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StoreTag extends StatelessWidget {
  const StoreTag({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AlpacaColor.primary20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: AlpacaColor.primary80,
              fontSize: 12,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class StoreOverview extends StatelessWidget {
  const StoreOverview({
    Key? key,
    required this.name,
    required this.rating,
    required this.googleMaps,
    required this.walkingTime,
    required this.walkingDistance,
  }) : super(key: key);

  final String name;
  final String rating;
  final String googleMaps;
  final String walkingTime;
  final String walkingDistance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline3!.merge(
                      const TextStyle(
                        fontSize: 22,
                      ),
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(
                    color: AlpacaColor.lightGreyColor90,
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.directions_walk_rounded,
                        size: 18,
                      ),
                    ),
                    Text(
                      '${walkingTime}m ($walkingDistance)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff848484),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              StoreTag(name: 'Chinese'),
              SizedBox(width: 6),
              StoreTag(name: 'Noodles'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Color(0xff2b2d42),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.star,
                        color: AlpacaColor.goldColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Get directions',
                      style: TextStyle(
                        color: Color(0xff6400fe),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AlpacaColor.primary100,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
