import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreInformationItem extends StatelessWidget {
  const StoreInformationItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            color: AlpacaColor.primary60,
            height: 18,
            width: 18,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 1.5),
          //   child: Icon(icon, size: 24, color: AlpacaColor.primary80),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: AlpacaColor.lightGreyColor100,
                        ),
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AlpacaColor.darkNavyColor,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
