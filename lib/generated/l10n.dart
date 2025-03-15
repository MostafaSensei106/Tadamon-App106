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

  /// `تضامن`
  String get appName {
    return Intl.message(
      'تضامن',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `دعم فلسطين واجب إنساني. مقاطعة الشركات الداعمة للاحتلال هي صوت الحرية.`
  String get appDescription {
    return Intl.message(
      'دعم فلسطين واجب إنساني. مقاطعة الشركات الداعمة للاحتلال هي صوت الحرية.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get home {
    return Intl.message(
      'الرئيسية',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `بحث`
  String get search {
    return Intl.message(
      'بحث',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `السجلات`
  String get logs {
    return Intl.message(
      'السجلات',
      name: 'logs',
      desc: '',
      args: [],
    );
  }

  /// `فحص الباركود`
  String get scanBarcode {
    return Intl.message(
      'فحص الباركود',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `تحليل الصور`
  String get imageAnalysis {
    return Intl.message(
      'تحليل الصور',
      name: 'imageAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `تعديل النص`
  String get editText {
    return Intl.message(
      'تعديل النص',
      name: 'editText',
      desc: '',
      args: [],
    );
  }

  /// `خريطة فلسطين`
  String get palestineMap {
    return Intl.message(
      'خريطة فلسطين',
      name: 'palestineMap',
      desc: '',
      args: [],
    );
  }

  /// `تبرع لغزة`
  String get donate {
    return Intl.message(
      'تبرع لغزة',
      name: 'donate',
      desc: '',
      args: [],
    );
  }

  /// `المنتجات التي تمت مراجعتها`
  String get scannedProducts {
    return Intl.message(
      'المنتجات التي تمت مراجعتها',
      name: 'scannedProducts',
      desc: '',
      args: [],
    );
  }

  /// `المنتجات التي تم دعمها`
  String get supportedProducts {
    return Intl.message(
      'المنتجات التي تم دعمها',
      name: 'supportedProducts',
      desc: '',
      args: [],
    );
  }

  /// `لون واجهة التطبيق`
  String get systemTheme {
    return Intl.message(
      'لون واجهة التطبيق',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `مطابقة لون النظام`
  String get followSystemTheme {
    return Intl.message(
      'مطابقة لون النظام',
      name: 'followSystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `الوضع الداكن`
  String get darkTheme {
    return Intl.message(
      'الوضع الداكن',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `الوضع الفاتح`
  String get lightTheme {
    return Intl.message(
      'الوضع الفاتح',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الداكن`
  String get switchToDarkTheme {
    return Intl.message(
      'التبديل إلى الوضع الداكن',
      name: 'switchToDarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الفاتح`
  String get switchToLightTheme {
    return Intl.message(
      'التبديل إلى الوضع الفاتح',
      name: 'switchToLightTheme',
      desc: '',
      args: [],
    );
  }

  /// `تضامن دون إنترنت`
  String get appOffline {
    return Intl.message(
      'تضامن دون إنترنت',
      name: 'appOffline',
      desc: '',
      args: [],
    );
  }

  /// `التطبيق غير متصل.`
  String get appOfflineMessageDontRunning {
    return Intl.message(
      'التطبيق غير متصل.',
      name: 'appOfflineMessageDontRunning',
      desc: '',
      args: [],
    );
  }

  /// `التطبيق يعمل بنجاح.`
  String get appOnlineMessageRunning {
    return Intl.message(
      'التطبيق يعمل بنجاح.',
      name: 'appOnlineMessageRunning',
      desc: '',
      args: [],
    );
  }

  /// `انتظر ...`
  String get appOfflineLoading {
    return Intl.message(
      'انتظر ...',
      name: 'appOfflineLoading',
      desc: '',
      args: [],
    );
  }

  /// `تحميل قائمة المنتجات`
  String get enableOnline {
    return Intl.message(
      'تحميل قائمة المنتجات',
      name: 'enableOnline',
      desc: '',
      args: [],
    );
  }

  /// `تشغيل التطبيق بدون إنترنت.`
  String get enableOnlineMessage {
    return Intl.message(
      'تشغيل التطبيق بدون إنترنت.',
      name: 'enableOnlineMessage',
      desc: '',
      args: [],
    );
  }

  /// `حذف السجلات`
  String get clearLogs {
    return Intl.message(
      'حذف السجلات',
      name: 'clearLogs',
      desc: '',
      args: [],
    );
  }

  /// `مسح سجلات المنتجات في التطبيق.`
  String get clearLogsMessage {
    return Intl.message(
      'مسح سجلات المنتجات في التطبيق.',
      name: 'clearLogsMessage',
      desc: '',
      args: [],
    );
  }

  /// `الأسئلة الشائعة`
  String get howToUse {
    return Intl.message(
      'الأسئلة الشائعة',
      name: 'howToUse',
      desc: '',
      args: [],
    );
  }

  /// `تعرف على طريقة استخدام التطبيق.`
  String get howToUseMessage {
    return Intl.message(
      'تعرف على طريقة استخدام التطبيق.',
      name: 'howToUseMessage',
      desc: '',
      args: [],
    );
  }

  /// `الإبلاغ عن منتج`
  String get reportProduct {
    return Intl.message(
      'الإبلاغ عن منتج',
      name: 'reportProduct',
      desc: '',
      args: [],
    );
  }

  /// `ساعدنا في تحسين التطبيق.`
  String get reportProductMessage {
    return Intl.message(
      'ساعدنا في تحسين التطبيق.',
      name: 'reportProductMessage',
      desc: '',
      args: [],
    );
  }

  /// `تجريبي`
  String get test {
    return Intl.message(
      'تجريبي',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المنتج`
  String get sheetTitleProductInfo {
    return Intl.message(
      'تفاصيل المنتج',
      name: 'sheetTitleProductInfo',
      desc: '',
      args: [],
    );
  }

  /// `المطور`
  String get developer {
    return Intl.message(
      'المطور',
      name: 'developer',
      desc: '',
      args: [],
    );
  }

  /// `Mostafa Mahmoud`
  String get mostafaMahmoud {
    return Intl.message(
      'Mostafa Mahmoud',
      name: 'mostafaMahmoud',
      desc: '',
      args: [],
    );
  }

  /// `ReadMe`
  String get readMe {
    return Intl.message(
      'ReadMe',
      name: 'readMe',
      desc: '',
      args: [],
    );
  }

  /// `رابط إلى مستودع التطبيق على جيت هاب.`
  String get readMeMessage {
    return Intl.message(
      'رابط إلى مستودع التطبيق على جيت هاب.',
      name: 'readMeMessage',
      desc: '',
      args: [],
    );
  }

  /// `آخر التحديثات`
  String get latestUpdate {
    return Intl.message(
      'آخر التحديثات',
      name: 'latestUpdate',
      desc: '',
      args: [],
    );
  }

  /// `اطلع على التحديثات وسجل التغييرات.`
  String get latestUpdateMessage {
    return Intl.message(
      'اطلع على التحديثات وسجل التغييرات.',
      name: 'latestUpdateMessage',
      desc: '',
      args: [],
    );
  }

  /// `تذكرة على جيت هاب`
  String get githubTicket {
    return Intl.message(
      'تذكرة على جيت هاب',
      name: 'githubTicket',
      desc: '',
      args: [],
    );
  }

  /// `الإبلاغ عن خطأ أو اقتراح ميزة جديدة.`
  String get githubTicketMessage {
    return Intl.message(
      'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.',
      name: 'githubTicketMessage',
      desc: '',
      args: [],
    );
  }

  /// `قناة تلغرام`
  String get telegramChannel {
    return Intl.message(
      'قناة تلغرام',
      name: 'telegramChannel',
      desc: '',
      args: [],
    );
  }

  /// `رابط إلى قناة تلغرام.`
  String get telegramChannelMessage {
    return Intl.message(
      'رابط إلى قناة تلغرام.',
      name: 'telegramChannelMessage',
      desc: '',
      args: [],
    );
  }

  /// `معلومات عن التطبيق`
  String get about {
    return Intl.message(
      'معلومات عن التطبيق',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `حول تطبيق تضامن.`
  String get aboutTadamon {
    return Intl.message(
      'حول تطبيق تضامن.',
      name: 'aboutTadamon',
      desc: '',
      args: [],
    );
  }

  /// `رسالة من المطور`
  String get contactDev {
    return Intl.message(
      'رسالة من المطور',
      name: 'contactDev',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد رسالة حالياً.`
  String get devMessage {
    return Intl.message(
      'لا توجد رسالة حالياً.',
      name: 'devMessage',
      desc: '',
      args: [],
    );
  }

  /// `شكراً لاستخدام تطبيق تضامن.`
  String get devThanks {
    return Intl.message(
      'شكراً لاستخدام تطبيق تضامن.',
      name: 'devThanks',
      desc: '',
      args: [],
    );
  }

  /// `ادعم المطور.`
  String get devDonate {
    return Intl.message(
      'ادعم المطور.',
      name: 'devDonate',
      desc: '',
      args: [],
    );
  }

  /// `تابعني على مواقع التواصل الاجتماعي.`
  String get contactDevMessage {
    return Intl.message(
      'تابعني على مواقع التواصل الاجتماعي.',
      name: 'contactDevMessage',
      desc: '',
      args: [],
    );
  }

  /// `إغلاق`
  String get close {
    return Intl.message(
      'إغلاق',
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
