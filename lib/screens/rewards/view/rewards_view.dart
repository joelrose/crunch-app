import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlpacaHeader(
          title: context.l10n.rewards,
          headerItems: [
            HeaderItem(
              onPressed: () {},
              svgPath: 'assets/icons/gift.svg',
            ),
            HeaderItem(
              onPressed: () {},
              svgPath: 'assets/icons/user-plus.svg',
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AlpacaColor.primary100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You have:',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '2085 points',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Redeem x points for 5€',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: AlpacaColor.white100Color,
                child: Text(
                  'JR',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: AlpacaColor.primary100,
                      ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
