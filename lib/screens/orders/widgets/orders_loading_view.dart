import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class OrdersLoadingView extends StatelessWidget {
  const OrdersLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      highlightColor: const Color(0xFFF1EFEF),
      builder: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Container(
                    width: 26,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 12.5, left: 39),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 140,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 130,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                  ),
                  Container(
                    width: 60,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(right: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 19,
              ),
              const Divider(
                height: 0,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
