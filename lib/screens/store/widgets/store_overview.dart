import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/store/widgets/store_rating.dart';
import 'package:pickup/screens/store/widgets/store_tag.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOverview extends StatelessWidget {
  const StoreOverview({
    Key? key,
    required this.name,
    required this.rating,
    required this.googleMaps,
  }) : super(key: key);

  static const String route = '/store-overview';

  final String name;
  final String rating;
  final String googleMaps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline2,
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
                        Icons.timelapse,
                        size: 18,
                      ),
                    ),
                    Text(
                      '20 min',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: AlpacaColor.greyColor80),
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
                StoreRating(rating: rating),
                GestureDetector(
                  onTap: () async {
                    await launch(googleMaps);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Get directions',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AlpacaColor.primary100,
                            ),
                      ),
                      const Padding(
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
