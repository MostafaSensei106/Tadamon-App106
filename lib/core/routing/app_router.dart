import 'package:flutter/material.dart';
import 'package:tadamon/core/error/no_routes.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/pages/help_user_page/ui/page/help_user_page.dart';
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
      case Routes.userHelp:
        page = const HelpUserPage ();
        break;
      default:
        page = const NoRoutes();
    }
    return _createPageRoute(page);
  }


/// Creates a [PageRouteBuilder] with a custom slide and fade transition.
///
/// The [page] parameter is the widget to display as the page. The transition
/// duration is set to 300 milliseconds for both entering and exiting transitions.
///
/// The transition consists of a fade effect combined with a slide effect from
/// the right side of the screen (offset (1.0, 0.0)) to the center (offset zero).
/// The slide transition uses an ease-in-out curve for a smooth animation.

  PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacityAnimation = animation.drive(Tween<double>(begin: 0.0, end: 1.0));
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: opacityAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
    );
  }

}
