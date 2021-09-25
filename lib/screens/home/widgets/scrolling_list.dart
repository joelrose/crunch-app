
import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';

class LeftToRightScrollingList extends StatelessWidget {
  const LeftToRightScrollingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Favourite stores',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AlpacaColor.darkNavyColor,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AlpacaColor.greyColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AlpacaColor.darkNavyColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(height: 18),
          Container(
            margin: const EdgeInsets.fromLTRB(18, 0, 0, 0),
            height: 194,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  height: 194,
                  width: 235,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AlpacaColor.white100Color,
                    boxShadow: [
                      BoxShadow(
                        color: AlpacaColor.blackColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 123,
                        decoration: const BoxDecoration(
                          color: AlpacaColor.greyColor,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
