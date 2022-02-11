import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/store/widgets/store_tag.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOverview extends StatelessWidget {
  const StoreOverview({
    Key? key,
    required this.name,
    required this.rating,
    required this.googleMaps,
    required this.walkingTime,
    required this.walkingDistance,
  }) : super(key: key);

  static const String route = '/store-overview';

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
                        color: AlpacaColor.darkNavyColor,
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
                GestureDetector(
                  onTap: () async {
                    await launch(googleMaps);
                  },
                  child: Row(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
