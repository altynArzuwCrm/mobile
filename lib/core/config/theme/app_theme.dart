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
      textTheme: const TextTheme(//filter
        titleLarge: TextStyle(
          color: AppColors.accent,
          fontSize: 22,
        ),
        titleMedium: TextStyle(//Последние заказы
          color: AppColors.accent,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(//Название заказа
          color: AppColors.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
    );
  }
}
