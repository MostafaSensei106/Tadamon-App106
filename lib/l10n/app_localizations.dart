import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar')
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'تضامن'**
  String get appName;

  /// No description provided for @appDescription.
  ///
  /// In ar, this message translates to:
  /// **'دعم فلسطين واجب إنساني. مقاطعة الشركات الداعمة للاحتلال هي صوت الحرية.'**
  String get appDescription;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @logs.
  ///
  /// In ar, this message translates to:
  /// **'السجلات'**
  String get logs;

  /// No description provided for @scanBarcode.
  ///
  /// In ar, this message translates to:
  /// **'فحص الباركود'**
  String get scanBarcode;

  /// No description provided for @imageAnalysis.
  ///
  /// In ar, this message translates to:
  /// **'تحليل الصور'**
  String get imageAnalysis;

  /// No description provided for @editText.
  ///
  /// In ar, this message translates to:
  /// **'تعديل النص'**
  String get editText;

  /// No description provided for @palestineMap.
  ///
  /// In ar, this message translates to:
  /// **'خريطة فلسطين'**
  String get palestineMap;

  /// No description provided for @donate.
  ///
  /// In ar, this message translates to:
  /// **'تبرع لغزة'**
  String get donate;

  /// No description provided for @scannedProducts.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي تمت مراجعتها'**
  String get scannedProducts;

  /// No description provided for @supportedProducts.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي تم دعمها'**
  String get supportedProducts;

  /// No description provided for @systemTheme.
  ///
  /// In ar, this message translates to:
  /// **'لون واجهة التطبيق'**
  String get systemTheme;

  /// No description provided for @followSystemTheme.
  ///
  /// In ar, this message translates to:
  /// **'مطابقة لون النظام'**
  String get followSystemTheme;

  /// No description provided for @darkTheme.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الفاتح'**
  String get lightTheme;

  /// No description provided for @switchToDarkTheme.
  ///
  /// In ar, this message translates to:
  /// **'التبديل إلى الوضع الداكن'**
  String get switchToDarkTheme;

  /// No description provided for @switchToLightTheme.
  ///
  /// In ar, this message translates to:
  /// **'التبديل إلى الوضع الفاتح'**
  String get switchToLightTheme;

  /// No description provided for @appOffline.
  ///
  /// In ar, this message translates to:
  /// **'تضامن دون إنترنت'**
  String get appOffline;

  /// No description provided for @appOfflineMessageDontRunning.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق غير متصل.'**
  String get appOfflineMessageDontRunning;

  /// No description provided for @appOnlineMessageRunning.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق يعمل بنجاح.'**
  String get appOnlineMessageRunning;

  /// No description provided for @appOfflineLoading.
  ///
  /// In ar, this message translates to:
  /// **'انتظر ...'**
  String get appOfflineLoading;

  /// No description provided for @enableOnline.
  ///
  /// In ar, this message translates to:
  /// **'تحميل قائمة المنتجات'**
  String get enableOnline;

  /// No description provided for @enableOnlineMessage.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل التطبيق بدون إنترنت.'**
  String get enableOnlineMessage;

  /// No description provided for @clearLogs.
  ///
  /// In ar, this message translates to:
  /// **'حذف السجلات'**
  String get clearLogs;

  /// No description provided for @clearLogsMessage.
  ///
  /// In ar, this message translates to:
  /// **'مسح سجلات المنتجات في التطبيق.'**
  String get clearLogsMessage;

  /// No description provided for @howToUse.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get howToUse;

  /// No description provided for @howToUseMessage.
  ///
  /// In ar, this message translates to:
  /// **'تعرف على طريقة استخدام التطبيق.'**
  String get howToUseMessage;

  /// No description provided for @reportProduct.
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن منتج'**
  String get reportProduct;

  /// No description provided for @reportProductMessage.
  ///
  /// In ar, this message translates to:
  /// **'ساعدنا في تحسين التطبيق.'**
  String get reportProductMessage;

  /// No description provided for @test.
  ///
  /// In ar, this message translates to:
  /// **'تجريبي'**
  String get test;

  /// No description provided for @sheetTitleProductInfo.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المنتج'**
  String get sheetTitleProductInfo;

  /// No description provided for @developer.
  ///
  /// In ar, this message translates to:
  /// **'المطور'**
  String get developer;

  /// No description provided for @mostafaMahmoud.
  ///
  /// In ar, this message translates to:
  /// **'Mostafa Mahmoud'**
  String get mostafaMahmoud;

  /// No description provided for @readMe.
  ///
  /// In ar, this message translates to:
  /// **'ReadMe'**
  String get readMe;

  /// No description provided for @readMeMessage.
  ///
  /// In ar, this message translates to:
  /// **'رابط إلى مستودع التطبيق على جيت هاب.'**
  String get readMeMessage;

  /// No description provided for @latestUpdate.
  ///
  /// In ar, this message translates to:
  /// **'آخر التحديثات'**
  String get latestUpdate;

  /// No description provided for @latestUpdateMessage.
  ///
  /// In ar, this message translates to:
  /// **'اطلع على التحديثات وسجل التغييرات.'**
  String get latestUpdateMessage;

  /// No description provided for @githubTicket.
  ///
  /// In ar, this message translates to:
  /// **'تذكرة على جيت هاب'**
  String get githubTicket;

  /// No description provided for @githubTicketMessage.
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن خطأ أو اقتراح ميزة جديدة.'**
  String get githubTicketMessage;

  /// No description provided for @telegramChannel.
  ///
  /// In ar, this message translates to:
  /// **'قناة تلغرام'**
  String get telegramChannel;

  /// No description provided for @telegramChannelMessage.
  ///
  /// In ar, this message translates to:
  /// **'رابط إلى قناة تلغرام.'**
  String get telegramChannelMessage;

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'معلومات عن التطبيق'**
  String get about;

  /// No description provided for @aboutTadamon.
  ///
  /// In ar, this message translates to:
  /// **'حول تطبيق تضامن.'**
  String get aboutTadamon;

  /// No description provided for @contactDev.
  ///
  /// In ar, this message translates to:
  /// **'رسالة من المطور'**
  String get contactDev;

  /// No description provided for @devMessage.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسالة حالياً.'**
  String get devMessage;

  /// No description provided for @devThanks.
  ///
  /// In ar, this message translates to:
  /// **'شكراً لاستخدام تطبيق تضامن.'**
  String get devThanks;

  /// No description provided for @devDonate.
  ///
  /// In ar, this message translates to:
  /// **'ادعم المطور.'**
  String get devDonate;

  /// No description provided for @contactDevMessage.
  ///
  /// In ar, this message translates to:
  /// **'تابعني على مواقع التواصل الاجتماعي.'**
  String get contactDevMessage;

  /// No description provided for @close.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
