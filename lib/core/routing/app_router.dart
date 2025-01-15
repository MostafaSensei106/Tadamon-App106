import 'package:flutter/material.dart';
import 'package:tadamon/core/error/no_routes.dart';
import 'package:tadamon/features/pages/main_page/ui/page/main_page.dart';

class AppRouter {
  /// The main route generator for the app.
  //
  /// This method is called by the [MaterialApp.onGenerateRoute] callback
  /// whenever a route is being pushed or popped from the navigator. The
  /// route to be generated is determined by the [RouteSettings.name]
  /// property.
  //
  /// Supported routes are:
  //
  /// - 'Routes.mainPage': The main page of the app.
  //
  /// All other routes are not supported and will result in the
  /// [NoRoutes] widget being shown.
  Route generateRoute(RouteSettings settings) {
    //final arguments = settings.arguments;
    switch (settings.name) {
      case 'Routes.mainPage':
        return MaterialPageRoute(
          builder: (context) => MainPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRoutes(),
        );
    }
  }
}
