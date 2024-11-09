import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case 'Routes.onBoardingScreen':
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );
      case 'Routes.loginScreen':
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => NoRoutes(),
        );
    }
  }
}
