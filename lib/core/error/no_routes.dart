import 'package:flutter/material.dart';

class NoRoutes extends StatelessWidget {
  const NoRoutes({super.key});

  @override
  /// Returns a [Scaffold] widget with a [Center] widget containing a [Text] widget
  /// that displays an error message when no route is defined for the current
  /// route name.
  ///
  /// The error message is displayed in red color and centered in the screen.
  ///
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'No route defined for ${ModalRoute.of(context)?.settings.name}',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    ));
  }
}
