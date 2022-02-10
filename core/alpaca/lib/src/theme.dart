import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
          color: AlpacaColor.white100Color,
        ),
        headline2: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
          color: AlpacaColor.darkNavyColor,
          letterSpacing: -1.5
        ),
        headline3: TextStyle(
          color: AlpacaColor.lightBlackColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
        ),
        subtitle1: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AlpacaColor.white100Color
        ),
        subtitle2: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AlpacaColor.greyColor80
        ),
        bodyText1: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          height: 1.4,
          color: AlpacaColor.greyColor80
        ),
        bodyText2: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        button: TextStyle(
          color: AlpacaColor.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1,
        )),
  );
}
