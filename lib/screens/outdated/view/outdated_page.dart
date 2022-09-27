import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickup/l10n/l10n.dart';

class OutdatedPage extends StatelessWidget {
  const OutdatedPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (_) => const OutdatedPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PageWrapper(
      backgroundColor: AlpacaColor.primary100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/update.svg',
            width: width * 0.7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                    context.l10n.appOutdatedTitle,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 36,
                        color: AlpacaColor.white100Color,
                      ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 10),
                  child: Text(
                    context.l10n.appOutdatedSubtitle,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AlpacaColor.white100Color,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
