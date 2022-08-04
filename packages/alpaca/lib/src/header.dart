import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderItem {
  const HeaderItem({
    required this.onPressed,
    required this.svgPath,
  });

  final void Function()? onPressed;
  final String svgPath;
}

class AlpacaHeader extends StatelessWidget {
  const AlpacaHeader({
    Key? key,
    required this.title,
    this.headerItems,
  }) : super(key: key);

  final String title;

  final List<HeaderItem>? headerItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(
                        color: AlpacaColor.blackColor,
                      ),
                    ),
              ),
              Row(
                children: [
                  ...List.generate(
                    headerItems?.length ?? 0,
                    (index) {
                      final item = headerItems![index];

                      return Row(
                        children: [
                          if (index != 0)
                            Container(
                              width: 15,
                            ),
                          GestureDetector(
                            onTap: item.onPressed,
                            child: SvgPicture.asset(
                              item.svgPath,
                              height: 26,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
