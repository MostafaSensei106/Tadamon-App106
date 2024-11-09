import 'package:flutter/material.dart';
import 'package:tadamon_app/core/error/no_routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case 'Routes.onBoardingScreen':
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      case 'Routes.loginScreen':
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRoutes(),
        );
    }
  }
}
