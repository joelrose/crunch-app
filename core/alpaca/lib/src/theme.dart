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
      headline1: const TextStyle(
        color: AlpacaColor.white100Color,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: AlpacaColor.darkNavyColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.lexendDeca().fontFamily,
      ),
      headline3: const TextStyle(
        color: AlpacaColor.blackColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: const TextStyle(
        color: AlpacaColor.white80Color,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      subtitle2: const TextStyle(
        color: AlpacaColor.greyColor80,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      
      bodyText1: const TextStyle(
        color: AlpacaColor.blackColor,
      ),
      bodyText2: const TextStyle(
        color: AlpacaColor.white80Color,
      ),
    ),
  );
}
