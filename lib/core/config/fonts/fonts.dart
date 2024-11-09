import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppLanguage { arabic, english, japanese }

class AppTextStyle {
  static AppLanguage currentLanguage = AppLanguage.english;

  static String getFontFamily() {
    switch (currentLanguage) {
      case AppLanguage.english:
        return 'EnglishFont';
      case AppLanguage.arabic:
        return 'ArabicFont';
      case AppLanguage.japanese:
        return 'JapaneseFont';
    }
  }

  static TextStyle get headline1 => TextStyle(
        fontFamily: getFontFamily(),
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headline2 => TextStyle(
        fontFamily: getFontFamily(),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyText1 => TextStyle(
        fontFamily: getFontFamily(),
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyText2 => TextStyle(
        fontFamily: getFontFamily(),
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get button => TextStyle(
        fontFamily: getFontFamily(),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static void setLanguage(AppLanguage language) {
    currentLanguage = language;
  }
}
