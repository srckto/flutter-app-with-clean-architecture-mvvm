import 'package:flutter/material.dart';

class ColorManager {
  static final int _primaryValue = 0xffED9728;
  static final MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: const Color(0xFF000000),
      100: const Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: Color(_primaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );

  static const Color darkPrimary = Color(0xffED9728);
  static const Color lightPrimary = Color(0xCCED9728); // 80%

  static const Color grey = Color(0xff737477);
  static const Color darkGrey = Color(0xff525252);
  static const Color lightGrey = Color(0xff9E9E9E);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
}
