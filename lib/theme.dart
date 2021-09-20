import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    fontFamily: 'Poppins',
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.purple),
    appBarTheme: AppBarTheme(
      shadowColor: Theme.of(context).scaffoldBackgroundColor,
      color: Colors.purple,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.purple,
    ),
  );
}
