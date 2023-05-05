import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData theme = ThemeData(
    fontFamily: 'Lato',
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    cardColor: AppColors.surface,
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: AppColors.primary,
      suffixIconColor: AppColors.greyLight,
      errorMaxLines: 1,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
        ),
      ),
      errorStyle: TextStyle(color: AppColors.red),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
        ),
      ),
      floatingLabelStyle: TextStyle(color: AppColors.primary),
      labelStyle: TextStyle(color: AppColors.greyLight),
      helperStyle: TextStyle(color: AppColors.greyLight),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 40, color: AppColors.white),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.white),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.white),
      bodyLarge: TextStyle(fontSize: 18, color: AppColors.white),
      titleMedium: TextStyle(fontSize: 16, color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16),
        minimumSize: const Size(50, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionHandleColor: AppColors.accentColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.surface, elevation: 0, ),
  );
}
