import 'package:crm/core/constants/colors/app_colors.dart';
import 'package:crm/core/constants/strings/text_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgColor,
      fontFamily: TextFonts.nunito,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        shadowColor: Colors.white,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: TextFonts.nunito,
          fontSize: 20,
          color: AppColors.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    );
  }
}
