import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/shared/alpaca_divider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.link,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AlpacaDivider(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => launch(link),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: AlpacaColor.darkGreyColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
