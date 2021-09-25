import 'package:alpaca/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: AlpacaColor.white100Color,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: TextStyle(
        color: AlpacaColor.white80Color,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyText1: TextStyle(
        color: AlpacaColor.blackColor,
      ),
      bodyText2: TextStyle(
        color: AlpacaColor.white80Color,
      ),
    ),
  );
}
