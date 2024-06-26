import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingOverlayRepository {
  LoadingOverlayRepository();

  Future<void> show() async {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..indicatorSize = 45.0
      ..indicatorColor = AlpacaColor.white100Color
      ..backgroundColor = Colors.transparent
      ..textColor = AlpacaColor.darkNavyColor

      // TODO: temp workaround the theme
      ..textStyle = TextStyle(
        color: AlpacaColor.lightBlackColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
      ) // Theme.of(context).textTheme.headline3
      ..textPadding = const EdgeInsets.all(12)
      ..boxShadow = <BoxShadow>[]
      ..maskColor = const Color.fromARGB(140, 0, 0, 0);

    await EasyLoading.show(
      maskType: EasyLoadingMaskType.custom,
    );
  }

  Future<void> hide() async {
    await EasyLoading.dismiss();
  }

  Future<T> asyncLoading<T>(Future<T> asyncFunction) async {
    await show();

    final value = await asyncFunction;

    await hide();

    return value;
  }

  Widget Function(BuildContext, Widget?) initialize() {
    return EasyLoading.init();
  }
}
