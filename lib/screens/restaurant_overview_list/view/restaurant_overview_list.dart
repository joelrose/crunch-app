import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/screens/discover/cubit/discover_cubit.dart';
import 'package:pickup/screens/restaurant_card/restaurant_card.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({Key? key, this.isHorizontal = true})
      : super(key: key);

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (BuildContext context, state) {
        if (state.status.isSuccess) {
          return Container(
            padding: isHorizontal
                ? const EdgeInsets.symmetric(horizontal: 20)
                : EdgeInsets.zero,
            height: 195,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
              separatorBuilder: (context, index) => isHorizontal
                  ? const SizedBox(width: 25)
                  : const SizedBox(
                      height: 25,
                    ),
              itemCount: state.stores.length,
              itemBuilder: (context, index) {
                final restaurant = state.stores[index];
                return RestaurantCard(restaurant: restaurant);
              },
            ),
          );
        }

        return SkeletonLoader(
          builder: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 190,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: const SizedBox(
                    height: 190,
                    width: 235,
                  ),
                );
              },
            ),
          ),
          highlightColor: AlpacaColor.primary100,
        );
      },
    );
  }
}
