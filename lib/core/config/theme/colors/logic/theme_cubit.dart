
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_shared_preferences.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeSharedPreferences _themeSharedPreferences;
  final BuildContext _context;

  ThemeCubit({
    required ThemeSharedPreferences themeSharedPreferences,
    required BuildContext context,
  })  : _themeSharedPreferences = themeSharedPreferences,
        _context = context,
        super(const ThemeState(
          isDark: false,
          themeMode: ThemeMode.system,
        ));

  Future<void> _persistTheme(ThemeState state) async {
    await _themeSharedPreferences.setTheme(state.isDark);
    await _themeSharedPreferences.setThemeMode(state.themeMode);
  }

  Future<void> toggleTheme(bool isDark) async {
    final newState = state.copyWith(
      isDark: isDark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
    await _persistTheme(newState);
    emit(newState);
  }

  Future<void> setSystemTheme() async {
    final isDark =
        MediaQuery.of(_context).platformBrightness == Brightness.dark;
    final newState = state.copyWith(
      isDark: isDark,
      themeMode: ThemeMode.system,
    );
    await _persistTheme(newState);
    emit(newState);
  }

  Future<void> initializeTheme() async {
    final isFirstRun = await _themeSharedPreferences.isFirstRun();

    if (isFirstRun == null || isFirstRun) {
      await setSystemTheme();
      await _themeSharedPreferences.setFirstRun(false);
    } else {
      final isDark = await _themeSharedPreferences.getTheme();
      final savedMode = await _themeSharedPreferences.getThemeMode();

      if (savedMode == ThemeMode.system) {
        final platformBrightness = PlatformDispatcher.instance.platformBrightness;
        final newIsDark = platformBrightness == Brightness.dark;
        final newState = state.copyWith(
          isDark: newIsDark,
          themeMode: ThemeMode.system,
        );
        await _persistTheme(newState);
        emit(newState);
      } else {
        emit(state.copyWith(
          isDark: isDark,
          themeMode: savedMode,
        ));
      }
    }
  }
}
