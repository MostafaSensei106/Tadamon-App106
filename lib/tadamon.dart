import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/theme/colors/dark_theme.dart';
import 'package:tadamon/core/config/theme/colors/light_theme.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_cubit.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_shared_preferences.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_state.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/core/routing/routes.dart';

import 'generated/l10n.dart';

class TadamonApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  TadamonApp(AppRouter appRouter, {super.key});
  @override
  /// The build method for the [TadamonApp] widget.
  ///
  /// This method wraps the [MaterialApp] widget in a [BlocProvider] widget,
  /// which is used to provide a [ThemeCubit] to the app.
  ///
  /// The [ThemeCubit] is used to manage the app's theme, such as the light and
  /// dark themes.
  ///
  /// The [BlocBuilder] widget is used to rebuild the app when the theme changes.
  ///
  /// The [MaterialApp] widget is used to provide the app's title, theme, and
  /// routes.
  ///
  /// The [ScreenUtilInit] widget is used to initialize the [flutter_screenutil]
  /// package, which is used to provide a responsive layout for the app.
  ///
  /// The [designSize] property is set to the size of the iPhone 12 Pro Max,
  /// which is the size of the design file provided by the designer.
  ///
  /// The [minTextAdapt] property is set to true, which means that the text size
  /// will be adjusted based on the screen size.
  ///
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        lazy:true,
        create: (context) => ThemeCubit(
            themeSharedPreferences: ThemeSharedPreferences(), context: context)
          ..initializeTheme(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tadamon',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeState.themeMode,
              initialRoute: Routes.mainPage,
              onGenerateRoute: appRouter.generateRoute,
              locale: const Locale('ar','EG'),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
