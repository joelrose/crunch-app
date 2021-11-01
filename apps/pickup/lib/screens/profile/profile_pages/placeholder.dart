import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class PlaceholderSide extends StatelessWidget {
  const PlaceholderSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AlpacaColor.primary100,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(80),
          child: Text(
            'Placeholder',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .merge(const TextStyle(color: AlpacaColor.white100Color)),
          ),
        ),
      ),
    );
  }
}
