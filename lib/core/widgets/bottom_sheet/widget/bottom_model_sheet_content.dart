import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class BottomModelSheetContent extends StatelessWidget {
  final Widget child;
  final bool useColor;

  const BottomModelSheetContent(
      {super.key, required this.child, this.useColor = false});

  @override

  /// Returns a [Container] widget with the given properties.
  ///
  /// The [width] is set to [double.infinity] to take up the full width of the
  /// screen.
  ///
  /// The [decoration] is set to a [BoxDecoration] with a [BorderRadius] of
  /// [SenseiConst.inBorderRadius.r] and a [color] of either the
  /// [Theme.of(context).colorScheme.surfaceContainer] or [Colors.transparent] if
  /// [useColor] is set to false.
  ///
  /// The [child] is wrapped in a [SingleChildScrollView] widget to allow for
  /// scrolling if the content is larger than the screen size.
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
        color: useColor
            ? Theme.of(context).colorScheme.surfaceContainer
            : Colors.transparent,
      ),
      child: SingleChildScrollView(child: child),
    );
  }
}
