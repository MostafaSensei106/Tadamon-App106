import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

String getLanguageName(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'ar':
      return 'العربية';
    case 'ja':
      return '日本語';
    default:
      return 'القطة المشمشية';
  }
}

class LanguageDropdown extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale?) onChanged;

  const LanguageDropdown(
      {super.key, required this.currentLocale, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      elevation: 0,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
      iconSize: 30.sp,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      underline: Divider(),
      value: currentLocale,
      onChanged: onChanged,
      items: [
        _buildDropdownMenuItem(const Locale('en'), Icons.flag),
        _buildDropdownMenuItem(const Locale('ar'), Icons.public),
        _buildDropdownMenuItem(const Locale('ja'), Icons.language),
      ],
    );
  }

  DropdownMenuItem<Locale> _buildDropdownMenuItem(
      Locale locale, IconData icon) {
    return DropdownMenuItem(
      value: locale,
      child: Row(
        children: [
          Icon(icon, size: 30.sp),
          SizedBox(width: 10.w),
          Text(getLanguageName(locale)),
        ],
      ),
    );
  }
}
