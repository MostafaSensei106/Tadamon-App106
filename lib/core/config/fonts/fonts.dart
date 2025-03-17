import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static final Map<String, TextStyle> _styleCache = {};

  static TextStyle _getTextStyle({
    required BuildContext context,
    required String key,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    if (_styleCache.containsKey(key)) {
      return _styleCache[key]!;
    }
    final style = TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    );
    _styleCache[key] = style;
    return style;
  }

  static TextStyle headline1(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'headline1',
      );

  static TextStyle headline2(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'headline2',
      );

  static TextStyle bodyText1(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'bodyText1',
      );

  static TextStyle bodyText2(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'bodyText2',
      );

  static TextStyle button(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'button',
      );

  static TextStyle hint(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x50),
        key: 'hint',
      );

  static TextStyle disabled(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x20),
        key: 'disabled',
      );

  static TextStyle caption(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary,
        key: 'caption',
      );

  static TextStyle captionLight(BuildContext context) => _getTextStyle(
        context: context,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(0x50),
        key: 'captionLight',
      );
}
