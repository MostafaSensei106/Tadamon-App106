import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:flutter/services.dart';
class ActionDrawerIcon extends StatelessWidget {
  const ActionDrawerIcon({super.key});

  /// Open the drawer with haptic feedback.
  ///
  /// Calls [HapticFeedback.vibrate] to generate a haptic feedback,
  /// then calls [Scaffold.of(context).openDrawer] to open the drawer.
  void openDrawer(context) {
    HapticFeedback.vibrate();
    Scaffold.of(context).openDrawer();
  }

  @override
  /// Returns a [Padding] widget with a [Material] widget as child.
  ///
  /// The [Material] widget is configured with a transparent color and a
  /// [InkWell] widget as child.
  ///
  /// The [InkWell] widget is configured with a rounded border with the
  /// [SenseiConst.outBorderRadius] radius, and an [onTap] callback that calls
  /// [openDrawer] with the given [context].
  ///
  /// The [InkWell] widget has a [_ActionDrawerContainer] widget as child,
  /// which is a [Container] widget with a rounded border and a transparent
  /// color.
  ///
  /// The [_ActionDrawerContainer] widget has a [_ActionDrawerIcon] widget as
  /// child, which is a [Icon] widget with the [Icons.more_vert_rounded] icon.
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 17.r, bottom: 8.r),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          onTap: () => openDrawer(context),
          child: _ActionDrawerContainer(
            child: _ActionDrawerIcon(),
          ),
        ),
      ),
    );
  }
}

class _ActionDrawerContainer extends StatelessWidget {
  final Widget child;

  const _ActionDrawerContainer({
    required this.child,
  });

  @override
  /// Returns a [Container] widget with the given properties.
  ///
  /// The [padding] is set to [const EdgeInsets.all(8)].
  ///
  /// The [decoration] is set to a [BoxDecoration] with a [BorderRadius] of
  /// [SenseiConst.outBorderRadius.r] and a [color] of the
  /// [Theme.of(context).colorScheme.surfaceContainerHigh] color with an alpha
  /// value of 0.3.
  ///
  /// The [child] is passed as-is.
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        color:
            Theme.of(context).colorScheme.surfaceContainerHigh.withAlpha((0.3 * 255).toInt()),
      ),
      child: child,
    );
  }
}

class _ActionDrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.more_vert_rounded,
      size: SenseiConst.iconSize.sp,
    );
  }
}
