import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/theme/colors/dark_theme.dart';
import 'package:tadamon_app/core/config/theme/colors/light_theme.dart';
import 'package:tadamon_app/core/routing/app_router.dart';
import 'package:tadamon_app/generated/l10n.dart';

class TadamonApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  TadamonApp(AppRouter appRouter, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'تضامن',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: 'Routes.mainPage',
        onGenerateRoute: appRouter.generateRoute,
        locale: const Locale('ar'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('ar'),
        ],
      ),
    );
  }
}
