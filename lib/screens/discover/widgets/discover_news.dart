import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/l10n/l10n.dart';

class DiscoverNews extends StatelessWidget {
  const DiscoverNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      width: double.infinity,
      height: 120,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.discoverTitle,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    context.l10n.discoverSubtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AlpacaColor.white100Color),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
