import 'package:alpaca/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingPageWrapper extends StatelessWidget {
  const OnboardingPageWrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    this.statusBarStyle = SystemUiOverlayStyle.light,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final SystemUiOverlayStyle statusBarStyle; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlpacaColor.primary100,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: statusBarStyle,
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
