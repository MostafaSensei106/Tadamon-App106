import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPreferences {
  static const themeKey = 'theme';
  static const themeModeKey = 'themeMode';
  static const firstRunKey = 'firstRun';

  Future<void> setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(themeKey, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeKey) ?? false;
  }

  Future<bool?> isFirstRun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(firstRunKey);
  }

  Future<void> setFirstRun(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(firstRunKey, value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(themeModeKey, mode.index);
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final modeIndex = sharedPreferences.getInt(themeModeKey);
    return modeIndex != null ? ThemeMode.values[modeIndex] : ThemeMode.system;
  }
}
