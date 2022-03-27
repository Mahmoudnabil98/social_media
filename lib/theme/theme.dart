import 'package:flutter/material.dart';

Color primaryBlue = const Color(0xff2972ff);
Color textBlack = const Color(0xff222222);
Color textGrey = const Color(0xff94959b);
Color textWhiteGrey = const Color(0xfff1f1f5);

TextStyle heading2 = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle heading5 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle heading6 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle regular16pt = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

ThemeData lightTheme = ThemeData(
  backgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  fontFamily: 'Lato',
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0,
    backgroundColor: Colors.white,
  ),
);
final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  backgroundColor: Colors.black,
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.black,
    primaryVariant: Colors.black,
    secondary: Colors.red,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
  ),
);
