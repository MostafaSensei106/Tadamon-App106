import 'package:flutter/material.dart';
import 'package:tadamon/core/error/no_routes.dart';
import 'package:tadamon/features/main_page/ui/page/main_page.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
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
