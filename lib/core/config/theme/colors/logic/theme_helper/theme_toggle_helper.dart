import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_cubit/theme_cubit.dart';

void toggleTheme(bool value, BuildContext context) {
  if (value) {
    context.read<ThemeCubit>().setSystemTheme();
  } else {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    context.read<ThemeCubit>().toggleTheme(isDarkMode);
  }
}
