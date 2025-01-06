import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);

        final curve = CurveTween(curve: Curves.easeInOutCubic);
        final scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(0.2, 1, curve: curve.curve),
          ),
        );

        return SlideTransition(
          position: offsetAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
      child: Text(
        title,
        key: ValueKey<String>(title),
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.end,
      ),
    );
  }
}
