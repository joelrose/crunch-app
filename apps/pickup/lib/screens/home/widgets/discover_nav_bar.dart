import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/routes.dart';

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
            width: 75,
            color: AlpacaColor.primary100,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => {Navigator.of(context).pushNamed(profileRoute)},
            child: Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AlpacaColor.primary100,
                  width: 6 / MediaQuery.of(context).devicePixelRatio,
                ),
              ),
              child: Image.asset(
                'assets/placeholder/profile_img_placeholder.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
