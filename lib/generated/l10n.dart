// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tadamon`
  String get AppName {
    return Intl.message(
      'Tadamon',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `Tadamon App`
  String get AppDescription {
    return Intl.message(
      'Tadamon App',
      name: 'AppDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get Logs {
    return Intl.message(
      'Logs',
      name: 'Logs',
      desc: '',
      args: [],
    );
  }

  /// `Scan Barcode`
  String get ScanBarcode {
    return Intl.message(
      'Scan Barcode',
      name: 'ScanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Image Analysis`
  String get ImageAnalysis {
    return Intl.message(
      'Image Analysis',
      name: 'ImageAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Palatine Map`
  String get PalatineMap {
    return Intl.message(
      'Palatine Map',
      name: 'PalatineMap',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get Donate {
    return Intl.message(
      'Donate',
      name: 'Donate',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get SystemTheme {
    return Intl.message(
      'System Theme',
      name: 'SystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Follow System Theme`
  String get FollowSystemTheme {
    return Intl.message(
      'Follow System Theme',
      name: 'FollowSystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get DarkTheme {
    return Intl.message(
      'Dark Mode',
      name: 'DarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get LightTheme {
    return Intl.message(
      'Light Mode',
      name: 'LightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Switch to Dark Mode`
  String get SwitchToDarkTheme {
    return Intl.message(
      'Switch to Dark Mode',
      name: 'SwitchToDarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Switch to Light Mode`
  String get SwitchToLightTheme {
    return Intl.message(
      'Switch to Light Mode',
      name: 'SwitchToLightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Developer`
  String get Developer {
    return Intl.message(
      'Developer',
      name: 'Developer',
      desc: '',
      args: [],
    );
  }

  /// `Mostafa Mahmoud`
  String get MostafaMahmoud {
    return Intl.message(
      'Mostafa Mahmoud',
      name: 'MostafaMahmoud',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `About Tadamon`
  String get AboutTadamon {
    return Intl.message(
      'About Tadamon',
      name: 'AboutTadamon',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
