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

  /// `Supporting Palestine is a humanitarian duty. Boycotting companies supporting the occupation is a voice for freedom.`
  String get AppDescription {
    return Intl.message(
      'Supporting Palestine is a humanitarian duty. Boycotting companies supporting the occupation is a voice for freedom.',
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

  /// `Edit Text`
  String get EditText {
    return Intl.message(
      'Edit Text',
      name: 'EditText',
      desc: '',
      args: [],
    );
  }

  /// `Palestine Map`
  String get PalatineMap {
    return Intl.message(
      'Palestine Map',
      name: 'PalatineMap',
      desc: '',
      args: [],
    );
  }

  /// `Donate for Gaza`
  String get Donate {
    return Intl.message(
      'Donate for Gaza',
      name: 'Donate',
      desc: '',
      args: [],
    );
  }

  /// `Reviewed Products`
  String get scanedProducts {
    return Intl.message(
      'Reviewed Products',
      name: 'scanedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Supported Products`
  String get supportedProducts {
    return Intl.message(
      'Supported Products',
      name: 'supportedProducts',
      desc: '',
      args: [],
    );
  }

  /// `App Theme Color`
  String get SystemTheme {
    return Intl.message(
      'App Theme Color',
      name: 'SystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Match System Theme`
  String get FollowSystemTheme {
    return Intl.message(
      'Match System Theme',
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

  /// `تضامن دون إنترنت`
  String get AppOffLine {
    return Intl.message(
      'تضامن دون إنترنت',
      name: 'AppOffLine',
      desc: '',
      args: [],
    );
  }

  /// `التطبيق غير متصل.`
  String get AppOffLineMassageDontRunning {
    return Intl.message(
      'التطبيق غير متصل.',
      name: 'AppOffLineMassageDontRunning',
      desc: '',
      args: [],
    );
  }

  /// `التطبيق يعمل بنجاح.`
  String get AppOnLineMassageRunning {
    return Intl.message(
      'التطبيق يعمل بنجاح.',
      name: 'AppOnLineMassageRunning',
      desc: '',
      args: [],
    );
  }

  /// ` انتظر ...`
  String get AppOflineLoading {
    return Intl.message(
      ' انتظر ...',
      name: 'AppOflineLoading',
      desc: '',
      args: [],
    );
  }

  /// `Download Product List`
  String get EnableOnline {
    return Intl.message(
      'Download Product List',
      name: 'EnableOnline',
      desc: '',
      args: [],
    );
  }

  /// `Run the app without internet.`
  String get EnableOnlineMassage {
    return Intl.message(
      'Run the app without internet.',
      name: 'EnableOnlineMassage',
      desc: '',
      args: [],
    );
  }

  /// `Clear Logs`
  String get clearLogs {
    return Intl.message(
      'Clear Logs',
      name: 'clearLogs',
      desc: '',
      args: [],
    );
  }

  /// `Erase product logs in the app.`
  String get clearLogsMassage {
    return Intl.message(
      'Erase product logs in the app.',
      name: 'clearLogsMassage',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get HowToUse {
    return Intl.message(
      'FAQ',
      name: 'HowToUse',
      desc: '',
      args: [],
    );
  }

  /// `Learn how to use the app.`
  String get HowToUseMassage {
    return Intl.message(
      'Learn how to use the app.',
      name: 'HowToUseMassage',
      desc: '',
      args: [],
    );
  }

  /// `Report Product`
  String get ReportProduct {
    return Intl.message(
      'Report Product',
      name: 'ReportProduct',
      desc: '',
      args: [],
    );
  }

  /// `Help us improve the app.`
  String get ReportProductMassage {
    return Intl.message(
      'Help us improve the app.',
      name: 'ReportProductMassage',
      desc: '',
      args: [],
    );
  }

  /// `Report Issue`
  String get ReportBug {
    return Intl.message(
      'Report Issue',
      name: 'ReportBug',
      desc: '',
      args: [],
    );
  }

  /// `Facing an issue? Report it.`
  String get ReportBugMassage {
    return Intl.message(
      'Facing an issue? Report it.',
      name: 'ReportBugMassage',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get Test {
    return Intl.message(
      'Test',
      name: 'Test',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get SheetTitleProductInfo {
    return Intl.message(
      'Product Details',
      name: 'SheetTitleProductInfo',
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

  /// `Read Me`
  String get ReadMe {
    return Intl.message(
      'Read Me',
      name: 'ReadMe',
      desc: '',
      args: [],
    );
  }

  /// `App repository on GitHub.`
  String get ReadMeMassage {
    return Intl.message(
      'App repository on GitHub.',
      name: 'ReadMeMassage',
      desc: '',
      args: [],
    );
  }

  /// `Latest Updates`
  String get LetastUpdate {
    return Intl.message(
      'Latest Updates',
      name: 'LetastUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Check updates and changelog.`
  String get LetestUpdateMassage {
    return Intl.message(
      'Check updates and changelog.',
      name: 'LetestUpdateMassage',
      desc: '',
      args: [],
    );
  }

  /// `GitHub Ticket`
  String get GithubTiket {
    return Intl.message(
      'GitHub Ticket',
      name: 'GithubTiket',
      desc: '',
      args: [],
    );
  }

  /// `Report an issue or suggest a new feature.`
  String get GithubTiketMassage {
    return Intl.message(
      'Report an issue or suggest a new feature.',
      name: 'GithubTiketMassage',
      desc: '',
      args: [],
    );
  }

  /// `Telegram Channel`
  String get TelegramChannel {
    return Intl.message(
      'Telegram Channel',
      name: 'TelegramChannel',
      desc: '',
      args: [],
    );
  }

  /// `Link to Telegram channel.`
  String get TelegramChannelMassage {
    return Intl.message(
      'Link to Telegram channel.',
      name: 'TelegramChannelMassage',
      desc: '',
      args: [],
    );
  }

  /// `About the App`
  String get About {
    return Intl.message(
      'About the App',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `About Tadamon App.`
  String get AboutTadamon {
    return Intl.message(
      'About Tadamon App.',
      name: 'AboutTadamon',
      desc: '',
      args: [],
    );
  }

  /// `Message from Developer`
  String get ContactDev {
    return Intl.message(
      'Message from Developer',
      name: 'ContactDev',
      desc: '',
      args: [],
    );
  }

  /// `No message available.`
  String get DevMassage {
    return Intl.message(
      'No message available.',
      name: 'DevMassage',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for using Tadamon.`
  String get DevThx {
    return Intl.message(
      'Thank you for using Tadamon.',
      name: 'DevThx',
      desc: '',
      args: [],
    );
  }

  /// `Support the Developer.`
  String get DevDonate {
    return Intl.message(
      'Support the Developer.',
      name: 'DevDonate',
      desc: '',
      args: [],
    );
  }

  /// `Follow me on social media.`
  String get ContactDevMassage {
    return Intl.message(
      'Follow me on social media.',
      name: 'ContactDevMassage',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
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
