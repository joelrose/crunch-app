import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConstructionScreen extends StatelessWidget {
  const ConstructionScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1!.merge(
                  const TextStyle(
                    color: AlpacaColor.blackColor,
                  ),
                ),
          ),
        ),
        const Divider(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/under-construction.svg',
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Text(
                  'Hey, we building something great here. Stay tuned!',
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                          color: AlpacaColor.darkGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 100)
            ],
          ),
        ),
      ],
    );
  }
}
