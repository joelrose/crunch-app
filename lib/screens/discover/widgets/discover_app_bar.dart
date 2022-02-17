import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickup/screens/profile/profile.dart';

class DiscoverAppBar extends StatelessWidget {
  const DiscoverAppBar({Key? key}) : super(key: key);

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
          Bounceable(
            scaleFactor: 0.5,
            onTap: () => Navigator.of(context).pushNamed(
              ProfileScreen.route,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                height: 28,
                color: AlpacaColor.primary100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
