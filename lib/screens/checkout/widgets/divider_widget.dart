import 'package:flutter/material.dart';

class divider_widget extends StatelessWidget {
  const divider_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(),
    );
  }
}
