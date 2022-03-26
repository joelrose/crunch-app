import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
        color: AlpacaColor.white100Color,
        letterSpacing: -0.015
      ),
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
        color: AlpacaColor.darkNavyColor,
        letterSpacing: -0.015
      ),
      headline3: TextStyle(
        color: AlpacaColor.lightBlackColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
      ),
      headline4: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 15,
          letterSpacing: -0.02,
          color: AlpacaColor.greyColor80),
      headline5: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 15,
          letterSpacing: -0.02,
          color: AlpacaColor.greyColor80),
      subtitle1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
        color: AlpacaColor.white100Color,
      ),
      bodyText1: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 12,
          color: AlpacaColor.greyColor80),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 12,
          color: AlpacaColor.greyColor80),
      caption: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 11,
          color: AlpacaColor.greyColor80),
      button: TextStyle(
        color: AlpacaColor.blackColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      overline: TextStyle(
        color: AlpacaColor.blackColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
