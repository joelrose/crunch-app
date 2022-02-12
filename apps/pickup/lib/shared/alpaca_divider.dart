import 'package:flutter/material.dart';

class AlpacaDivider extends StatelessWidget {
  const AlpacaDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).dividerColor, height: 0.5);
  }
}
