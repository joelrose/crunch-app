import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

CupertinoThemeData getThemeData(BuildContext context) {
  return CupertinoThemeData(
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      textStyle: GoogleFonts.inter(
        textStyle: const TextStyle(
          color: Color.fromRGBO(43, 45, 66, 1),
          letterSpacing: .5,
        ),
      ),
    ),
  );
}
