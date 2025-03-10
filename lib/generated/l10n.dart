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
  String get AppName {
    return Intl.message(
      'تضامن',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `دعم فلسطين واجب إنساني. مقاطعة الشركات الداعمة للاحتلال هي صوت الحرية.`
  String get AppDescription {
    return Intl.message(
      'دعم فلسطين واجب إنساني. مقاطعة الشركات الداعمة للاحتلال هي صوت الحرية.',
      name: 'AppDescription',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get Home {
    return Intl.message(
      'الرئيسية',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `بحث`
  String get Search {
    return Intl.message(
      'بحث',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `السجلات`
  String get Logs {
    return Intl.message(
      'السجلات',
      name: 'Logs',
      desc: '',
      args: [],
    );
  }

  /// `فحص الباركود`
  String get ScanBarcode {
    return Intl.message(
      'فحص الباركود',
      name: 'ScanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `تحليل الصور`
  String get ImageAnalysis {
    return Intl.message(
      'تحليل الصور',
      name: 'ImageAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `تعديل النص`
  String get EditText {
    return Intl.message(
      'تعديل النص',
      name: 'EditText',
      desc: '',
      args: [],
    );
  }

  /// `خريطة فلسطين`
  String get PalatineMap {
    return Intl.message(
      'خريطة فلسطين',
      name: 'PalatineMap',
      desc: '',
      args: [],
    );
  }

  /// `تبرع لغزة`
  String get Donate {
    return Intl.message(
      'تبرع لغزة',
      name: 'Donate',
      desc: '',
      args: [],
    );
  }

  /// `المنتجات التي تمت مراجعتها`
  String get scanedProducts {
    return Intl.message(
      'المنتجات التي تمت مراجعتها',
      name: 'scanedProducts',
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
  String get SystemTheme {
    return Intl.message(
      'لون واجهة التطبيق',
      name: 'SystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `مطابقة لون النظام`
  String get FollowSystemTheme {
    return Intl.message(
      'مطابقة لون النظام',
      name: 'FollowSystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `الوضع الداكن`
  String get DarkTheme {
    return Intl.message(
      'الوضع الداكن',
      name: 'DarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `الوضع الفاتح`
  String get LightTheme {
    return Intl.message(
      'الوضع الفاتح',
      name: 'LightTheme',
      desc: '',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الداكن`
  String get SwitchToDarkTheme {
    return Intl.message(
      'التبديل إلى الوضع الداكن',
      name: 'SwitchToDarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `التبديل إلى الوضع الفاتح`
  String get SwitchToLightTheme {
    return Intl.message(
      'التبديل إلى الوضع الفاتح',
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

  /// `تحميل قائمة المنتجات`
  String get EnableOnline {
    return Intl.message(
      'تحميل قائمة المنتجات',
      name: 'EnableOnline',
      desc: '',
      args: [],
    );
  }

  /// `تشغيل التطبيق بدون إنترنت.`
  String get EnableOnlineMassage {
    return Intl.message(
      'تشغيل التطبيق بدون إنترنت.',
      name: 'EnableOnlineMassage',
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
  String get clearLogsMassage {
    return Intl.message(
      'مسح سجلات المنتجات في التطبيق.',
      name: 'clearLogsMassage',
      desc: '',
      args: [],
    );
  }

  /// `الأسئلة الشائعة`
  String get HowToUse {
    return Intl.message(
      'الأسئلة الشائعة',
      name: 'HowToUse',
      desc: '',
      args: [],
    );
  }

  /// `تعرف على طريقة استخدام التطبيق.`
  String get HowToUseMassage {
    return Intl.message(
      'تعرف على طريقة استخدام التطبيق.',
      name: 'HowToUseMassage',
      desc: '',
      args: [],
    );
  }

  /// `الإبلاغ عن منتج`
  String get ReportProduct {
    return Intl.message(
      'الإبلاغ عن منتج',
      name: 'ReportProduct',
      desc: '',
      args: [],
    );
  }

  /// `ساعدنا في تحسين التطبيق.`
  String get ReportProductMassage {
    return Intl.message(
      'ساعدنا في تحسين التطبيق.',
      name: 'ReportProductMassage',
      desc: '',
      args: [],
    );
  }

  /// `تجريبي`
  String get Test {
    return Intl.message(
      'تجريبي',
      name: 'Test',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المنتج`
  String get SheetTitleProductInfo {
    return Intl.message(
      'تفاصيل المنتج',
      name: 'SheetTitleProductInfo',
      desc: '',
      args: [],
    );
  }

  /// `المطور`
  String get Developer {
    return Intl.message(
      'المطور',
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

  /// `ReadMe`
  String get ReadMe {
    return Intl.message(
      'ReadMe',
      name: 'ReadMe',
      desc: '',
      args: [],
    );
  }

  /// `رابط إلى مستودع التطبيق على جيت هاب.`
  String get ReadMeMassage {
    return Intl.message(
      'رابط إلى مستودع التطبيق على جيت هاب.',
      name: 'ReadMeMassage',
      desc: '',
      args: [],
    );
  }

  /// `آخر التحديثات`
  String get LetastUpdate {
    return Intl.message(
      'آخر التحديثات',
      name: 'LetastUpdate',
      desc: '',
      args: [],
    );
  }

  /// `اطلع على التحديثات وسجل التغييرات.`
  String get LetestUpdateMassage {
    return Intl.message(
      'اطلع على التحديثات وسجل التغييرات.',
      name: 'LetestUpdateMassage',
      desc: '',
      args: [],
    );
  }

  /// `تذكرة على جيت هاب`
  String get GithubTiket {
    return Intl.message(
      'تذكرة على جيت هاب',
      name: 'GithubTiket',
      desc: '',
      args: [],
    );
  }

  /// `الإبلاغ عن خطأ أو اقتراح ميزة جديدة.`
  String get GithubTiketMassage {
    return Intl.message(
      'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.',
      name: 'GithubTiketMassage',
      desc: '',
      args: [],
    );
  }

  /// `قناة تلغرام`
  String get TelegramChannel {
    return Intl.message(
      'قناة تلغرام',
      name: 'TelegramChannel',
      desc: '',
      args: [],
    );
  }

  /// `رابط إلى قناة تلغرام.`
  String get TelegramChannelMassage {
    return Intl.message(
      'رابط إلى قناة تلغرام.',
      name: 'TelegramChannelMassage',
      desc: '',
      args: [],
    );
  }

  /// `معلومات عن التطبيق`
  String get About {
    return Intl.message(
      'معلومات عن التطبيق',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `حول تطبيق تضامن.`
  String get AboutTadamon {
    return Intl.message(
      'حول تطبيق تضامن.',
      name: 'AboutTadamon',
      desc: '',
      args: [],
    );
  }

  /// `رسالة من المطور`
  String get ContactDev {
    return Intl.message(
      'رسالة من المطور',
      name: 'ContactDev',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد رسالة حالياً.`
  String get DevMassage {
    return Intl.message(
      'لا توجد رسالة حالياً.',
      name: 'DevMassage',
      desc: '',
      args: [],
    );
  }

  /// `شكراً لاستخدام تطبيق تضامن.`
  String get DevThx {
    return Intl.message(
      'شكراً لاستخدام تطبيق تضامن.',
      name: 'DevThx',
      desc: '',
      args: [],
    );
  }

  /// `ادعم المطور.`
  String get DevDonate {
    return Intl.message(
      'ادعم المطور.',
      name: 'DevDonate',
      desc: '',
      args: [],
    );
  }

  /// `تابعني على مواقع التواصل الاجتماعي.`
  String get ContactDevMassage {
    return Intl.message(
      'تابعني على مواقع التواصل الاجتماعي.',
      name: 'ContactDevMassage',
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
      Locale.fromSubtags(languageCode: 'en'),
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
