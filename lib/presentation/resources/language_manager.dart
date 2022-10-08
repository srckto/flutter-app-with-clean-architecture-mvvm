import 'package:flutter/material.dart';

enum LanguageType {
  ENGLISH,
  ARABIC,
}

const String ASSETS_PATH_LOCALIZATION = "assets/translations";

const String ARABIC_CODE = "ar";
const String ENGLISH_CODE = "en";

const Locale ARABIC_LOCAL = Locale("ar");
const Locale ENGLISH_LOCAL = Locale("en");

extension LanguageTypeExtension on LanguageType {
  String getLanguageCode() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH_CODE;
      case LanguageType.ARABIC:
        return ARABIC_CODE;
    }
  }
}
