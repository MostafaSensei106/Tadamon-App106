import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final bool isDark;
  final ThemeMode themeMode;

  const ThemeState({
    required this.isDark,
    required this.themeMode,
  });

  @override
  List<Object?> get props => [isDark, themeMode];

  /// Creates a new [ThemeState] with the given values.
  //
  /// If a value is not provided, the corresponding value from this [ThemeState]
  /// is used instead.
  ThemeState copyWith({
    bool? isDark,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
