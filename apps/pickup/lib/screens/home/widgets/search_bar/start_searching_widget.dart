import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class NotActiveSearchWidget extends StatelessWidget {
  const NotActiveSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Start searching',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AlpacaColor.darkNavyColor),
      ),
    );
  }
}
