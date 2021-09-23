import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/home/widgets/restaurant_random_picker.dart';
import 'package:alpaca/screens/home/widgets/scrolling_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const HomeHeader(),
          const Divider(
            height: 1,
          ),
          const RestaurantRandomPickGenerator(),
          Column(
            children: const [
              LeftToRightScrollingList(),
              LeftToRightScrollingList(),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 15.0,
      ),
      child: Column(
        children: const [
          DiscoverNavBar(),
          DiscoverSearchBar(),
        ],
      ),
    );
  }
}

class DiscoverNavBar extends StatelessWidget {
  const DiscoverNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/logo/crunch-logo.svg',
          width: 100,
          color: AlpacaColor.primary100,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => {Navigator.of(context).pushNamed(profileRoute)},
          child: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AlpacaColor.primary100, width: 3),
            ),
          ),
        )
      ],
    );
  }
}

class DiscoverSearchBar extends StatelessWidget {
  const DiscoverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: AlpacaColor.darkGreyColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              child: const Text(
                'Search for food, stores or tags',
                style: TextStyle(color: AlpacaColor.darkGreyColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
