import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key, required this.name, required this.id})
      : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline1!.merge(
                  const TextStyle(
                    color: AlpacaColor.blackColor,
                  ),
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AlpacaColor.lightGreyColor90,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Text(
              '#${id.substring(0, 3)}',
            ),
          ),
        ),
      ],
    );
  }
}
