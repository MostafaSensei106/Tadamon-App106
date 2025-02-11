import 'package:flutter/material.dart';
import 'package:tadamon/core/error/no_routes.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/pages/main_page/ui/page/main_page.dart';
import 'package:tadamon/features/pages/palestine_map/page/palestine_map_page.dart';

class AppRouter {
  /// Returns a route for the given [RouteSettings].
  ///
  /// The returned route is a [MaterialPageRoute] that knows how to build the
  /// page for the given route. The page is determined by the [RouteSettings.name]
  /// property. If the name is not recognized, a [NoRoutes] page is returned.
  ///
  /// The [MaterialPageRoute] is customized to have a slide transition.
  Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routes.mainPage:
        page = const MainPage();
        break;
      case Routes.palatineMap:
        page = const PalestineMapPage();
        break;
      default:
        page = const NoRoutes();
    }
    return _createPageRoute(page);
  }
/// Creates a [PageRouteBuilder] with a slide transition.
///
/// The transition slides the page from right to left with a duration of 250
/// milliseconds. The transition uses an ease-in-out curve for both forward
/// and reverse animation.
///
/// The [page] parameter specifies the widget to be displayed by the created
/// route.
///
/// The slide animation begins from the right edge of the screen (offset 1.0, 0.0)
/// and ends at the position (offset 0, 0).

 PageRouteBuilder _createPageRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); 
      const end = Offset.zero;          
      const curve = Curves.easeInOut;   
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

}
