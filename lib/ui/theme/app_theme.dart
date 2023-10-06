import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    hintColor: primary,
    shadowColor: primary,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      displayLarge: textStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 41,
      ),
      displayMedium: textStyle.copyWith(
        fontSize: 34,
      ),
      displaySmall: textStyle.copyWith(
        fontSize: 27,
      ),
      bodyLarge: textStyle.copyWith(
        fontSize: 22,
      ),
      bodyMedium: textStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: textStyle.copyWith(
        fontSize: 12,
      ),
    ),
  );

  static const textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: -.2,
  );

  static const Color primary = Color(0xff000000);
  static const Color secondary = Color(0xff515151);

  static const Color primaryButton = Color(0xff12555F);
  static const Color secondaryButton = Color(0xff081F32);
}
