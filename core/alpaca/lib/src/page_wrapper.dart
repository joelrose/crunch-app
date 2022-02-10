import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    this.statusBarStyle = SystemUiOverlayStyle.light,
    this.floatingActionButtonWidget,
    required this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final SystemUiOverlayStyle statusBarStyle;
  final Color backgroundColor;
  final Widget? floatingActionButtonWidget;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle,
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
          floatingActionButtonLocation: floatingActionButtonWidget != null
              ? FloatingActionButtonLocation.centerFloat
              : null,
          floatingActionButton: floatingActionButtonWidget),
    );
  }
}
