import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/home/widgets/restaurant_random_picker.dart';
import 'package:pickup/screens/home/widgets/scrolling_list.dart';
import 'package:pickup/screens/home/widgets/search_bar/main_search_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DiscoverSearchBar();
  }
}

class DiscoverBody extends StatelessWidget {
  const DiscoverBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AlpacaColor.white100Color,
                  AlpacaColor.lightGreyColor90,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: const [
                  Divider(
                    height: 1,
                  ),
                  RestaurantRandomPickGenerator(),
                  LeftToRightScrollingList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
