import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        theme: getThemeData(),
        home: navigator == null
            ? innerChild
            : MockNavigatorProvider(
                navigator: navigator,
                child: innerChild,
              ),
      ),
    );
  }
}
