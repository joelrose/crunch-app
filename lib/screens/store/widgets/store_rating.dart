import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreRating extends StatelessWidget {
  const StoreRating({Key? key, required this.rating}) : super(key: key);

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rating,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AlpacaColor.darkNavyColor,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: SvgPicture.asset(
            'assets/icons/starRating.svg',
            color: AlpacaColor.goldColor,
            height: 12,
            width: 13,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '(20 ratings)',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AlpacaColor.darkGreyColor,
                ),
          ),
        )
      ],
    );
  }
}
