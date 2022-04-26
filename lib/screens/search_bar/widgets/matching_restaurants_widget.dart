import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/restaurant_card/restaurant_card.dart';
import 'package:pickup/screens/search_bar/cubit/search_bar_cubit.dart';

class MatchingRestaurantsWidget extends StatelessWidget {
  const MatchingRestaurantsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stores = context.select((SearchBarCubit cubit) => cubit.state.stores);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Matching restaurants',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AlpacaColor.darkGreyColor,
                ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          clipBehavior: Clip.none,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                child: RestaurantCard(
                  restaurant: store,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
