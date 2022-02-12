import 'dart:ui';

import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class StoreImageNavbar extends StatelessWidget {
  const StoreImageNavbar({Key? key, required this.image, this.showButtons = true})
      : super(key: key);

  final bool showButtons;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(
            image,
          ).image,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            color: AlpacaColor.white100Color,
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
          ),
          if (showButtons)
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //     right: 10,
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(30),
                //     child: SizedBox(
                //       height: 40,
                //       width: 40,
                //       child: BackdropFilter(
                //         filter: ImageFilter.blur(
                //           sigmaX: 10,
                //           sigmaY: 10,
                //         ),
                //         child: IconButton(
                //           onPressed: () {},
                //           color: AlpacaColor.white100Color,
                //           icon: const Icon(
                //             Icons.star_border_outlined,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        color: AlpacaColor.white100Color,
                        icon: const Icon(Icons.info_outline),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
