import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class RestaurantRandomPickGenerator extends StatelessWidget {
  const RestaurantRandomPickGenerator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      width: double.infinity,
      height: 123,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AlpacaColor.primary100.withOpacity(1),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            AlpacaColor.primary100.withOpacity(0.2),
            BlendMode.dstATop,
          ),
          image: const AssetImage(
            'assets/placeholder/women_placeholder.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Not sure what \nto grab?',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: AlpacaColor.white100Color,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Lets find something together.',
                  style: TextStyle(
                    color: AlpacaColor.white100Color,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: AlpacaColor.white100Color,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 19,
              ),
            )
          ],
        ),
      ),
    );
  }
}
