import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
    this.statusBarStyle = SystemUiOverlayStyle.light,
    this.floatingActionButtonWidget,
    this.appBar,
    required this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final SystemUiOverlayStyle statusBarStyle;
  final Color backgroundColor;
  final Widget? floatingActionButtonWidget;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle,
      child: Scaffold(
          appBar: appBar,
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
          floatingActionButton: floatingActionButtonWidget,),
    );
  }
}
