import 'package:alpaca/global.dart';
import 'package:alpaca/routes.dart';
import 'package:alpaca/screens/home/widgets/floating_search_bar.dart';
import 'package:alpaca/screens/home/widgets/restaurant_random_picker.dart';
import 'package:alpaca/screens/home/widgets/scrolling_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchBar();
  }
}

class DiscoverBody extends StatelessWidget {
  const DiscoverBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Divider(
          height: 1,
        ),
        RestaurantRandomPickGenerator(),
        LeftToRightScrollingList(),
        LeftToRightScrollingList(),
      ],
    );
  }
}

class DiscoverSearchBar extends StatelessWidget {
  const DiscoverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
      ),
    );
  }
}
