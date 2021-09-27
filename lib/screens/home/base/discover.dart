import 'package:alpaca/screens/home/widgets/floating_search_bar.dart';
import 'package:alpaca/screens/home/widgets/restaurant_random_picker.dart';
import 'package:alpaca/screens/home/widgets/scrolling_list.dart';
import 'package:flutter/material.dart';

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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: const [
                Divider(
                  height: 1,
                ),
                RestaurantRandomPickGenerator(),
                LeftToRightScrollingList(),
                LeftToRightScrollingList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
