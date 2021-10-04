import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'Support',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .merge(const TextStyle(color: AlpacaColor.darkGreyColor)),
        ),
      ),
    );
  }
}
