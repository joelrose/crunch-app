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
            height: 200,
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
            height: 220,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: 2,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 195,
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 250,
                        height: 123,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 132,
                        height: 23,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: 112,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          highlightColor: const Color(0xFFF1EFEF),
        );
      },
    );
  }
}
