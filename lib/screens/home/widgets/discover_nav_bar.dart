import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoverNavBar extends StatelessWidget {
  const DiscoverNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 15.0,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/logo/crunch-logo.svg',
            width: 222.0 / MediaQuery.of(context).devicePixelRatio,
            color: AlpacaColor.primary100,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => {Navigator.of(context).pushNamed(profileRoute)},
            child: Container(
              height: 96 / MediaQuery.of(context).devicePixelRatio,
              width: 96 / MediaQuery.of(context).devicePixelRatio,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: AlpacaColor.primary100,
                    width: 6 / MediaQuery.of(context).devicePixelRatio),
              ),
            ),
          )
        ],
      ),
    );
  }
}
