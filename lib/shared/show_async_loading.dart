import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> showAsyncLoading(
  BuildContext context,
  Future<void> asyncFunction, [
  String loadingText = 'loading...',
  String successText = '',
  String errorText = '',
  EasyLoadingIndicatorType selectedIndicatorType =
      EasyLoadingIndicatorType.doubleBounce,
]) async {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = selectedIndicatorType
    ..indicatorSize = 50.0
    ..indicatorColor = AlpacaColor.primary100
    ..backgroundColor = AlpacaColor.white100Color
    ..textColor = AlpacaColor.darkNavyColor
    ..textStyle = Theme.of(context).textTheme.headline3
    ..textPadding = const EdgeInsets.all(12)
    ..maskColor = AlpacaColor.white100Color;
  EasyLoading.show(
    status: loadingText,
    maskType: EasyLoadingMaskType.custom,
  );
  await asyncFunction;
  EasyLoading.dismiss();
}
