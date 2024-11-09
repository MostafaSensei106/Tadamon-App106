import 'package:flutter/material.dart';

class NoRoutes extends StatelessWidget {
  const NoRoutes({super.key});

  @override
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
