import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme:  const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xfffff9f9),
    surfaceTint: Color(0xffffb4aa),
    onPrimary: Color(0xff000000),
    primaryContainer: Color(0xffffbab1),
    onPrimaryContainer: Color(0xff000000),
    secondary: Color(0xfffff9f9),
    onSecondary: Color(0xff000000),
    secondaryContainer: Color(0xffffbab1),
    onSecondaryContainer: Color(0xff000000),
    tertiary: Color(0xfffffaf7),
    onTertiary: Color(0xff000000),
    tertiaryContainer: Color(0xfffbc243),
    onTertiaryContainer: Color(0xff000000),
    error: Color(0xfffff9f9),
    onError: Color(0xff000000),
    errorContainer: Color(0xffffbab1),
    onErrorContainer: Color(0xff000000),
    surface: Color(0xff1c110f),
    onSurface: Color(0xffffffff),
    onSurfaceVariant: Color(0xfffff9f9),
    outline: Color(0xffe4c3bf),
    outlineVariant: Color(0xffe4c3bf),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfff5ddda),
    inversePrimary: Color(0xff5c0003),
    primaryFixed: Color(0xffffe0dc),
    onPrimaryFixed: Color(0xff000000),
    primaryFixedDim: Color(0xffffbab1),
    onPrimaryFixedVariant: Color(0xff370001),
    secondaryFixed: Color(0xffffe0dc),
    onSecondaryFixed: Color(0xff000000),
    secondaryFixedDim: Color(0xffffbab1),
    onSecondaryFixedVariant: Color(0xff310705),
    tertiaryFixed: Color(0xffffe3b2),
    onTertiaryFixed: Color(0xff000000),
    tertiaryFixedDim: Color(0xfffbc243),
    onTertiaryFixedVariant: Color(0xff1f1400),
    surfaceDim:  Color(0xff1c110f),
    surfaceBright: Color(0xff443634),
    surfaceContainerLowest: Color(0xff160b0a),
    surfaceContainerLow: Color(0xff251917),
    surfaceContainer: Color(0xff291d1b),
    surfaceContainerHigh: Color(0xff342725),
    surfaceContainerHighest: Color(0xff403130),
  ),
  fontFamily: 'ArabicFont',
  
    appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    foregroundColor: Colors.white,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(size: SenseiConst.iconSize,),
  ),

  // listTileTheme:  ListTileThemeData(
  //   subtitleTextStyle: AppTextStyle.subtitle(),
  //   ),

    


    
);
