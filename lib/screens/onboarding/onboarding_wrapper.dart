import 'package:alpaca/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingPageWrapper extends StatelessWidget {
  const OnboardingPageWrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlpacaColor.primary100,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
