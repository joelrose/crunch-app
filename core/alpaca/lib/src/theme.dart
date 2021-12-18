import 'package:alpaca/alpaca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
          color: AlpacaColor.darkNavyColor,
        ),
        headline2: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
          color: AlpacaColor.darkNavyColor,
        ),
        headline3: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.lexendDeca().fontFamily,
        ),
        subtitle1: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AlpacaColor.white100Color
        ),
        bodyText1: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1.4,
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
