import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/discover/widgets/widgets.dart';
import 'package:pickup/screens/search_bar/search_bar.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DiscoverView();
  }
}

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      child: Column(
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
                    DiscoverNews(),
                    RestaurantListSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
