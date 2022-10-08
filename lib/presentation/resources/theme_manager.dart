import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: FontConstants.fontFamily,
    primarySwatch: ColorManager.primary,
    disabledColor: ColorManager.lightGrey,
    scaffoldBackgroundColor: ColorManager.white,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      // shadowColor: ColorManager.lightPrimary,
      elevation: AppSize.s0,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        fontWeight: FontWightManager.regular,
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppSize.s0,
        padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
        onPrimary: ColorManager.white,
        textStyle: TextStyle(
          color: ColorManager.white,
          fontSize: FontSize.s17,
          fontWeight: FontWightManager.regular,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWightManager.bold,
        fontSize: FontSize.s18,
        color: ColorManager.primary,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWightManager.bold,
        fontSize: FontSize.s16,
        color: ColorManager.darkGrey,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWightManager.regular,
        fontSize: FontSize.s14,
        color: ColorManager.grey,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWightManager.regular,
        fontSize: FontSize.s18,
        color: ColorManager.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: FontSize.s16,
          fontWeight: FontWightManager.medium,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.white,
      elevation: AppSize.s0,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.lightGrey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      hintStyle: TextStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
        fontWeight: FontWightManager.regular,
      ),
      labelStyle: TextStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
        fontWeight: FontWightManager.medium,
      ),
      errorStyle: TextStyle(
        color: ColorManager.red,
        fontSize: FontSize.s14,
        fontWeight: FontWightManager.regular,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: 4,
        ),
      ),
    ),
  );
}
