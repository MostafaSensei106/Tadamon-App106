import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SidePageAppBar extends StatelessWidget {
  final String title;
  const SidePageAppBar({super.key, required this.title});

  /// Navigate back in the app by calling [Navigator.pop] on the given [context], and
  /// trigger a haptic feedback with [HapticFeedback.vibrate].
  void leave(BuildContext context) {
    HapticFeedback.vibrate();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
     // pinned: true,
      leading: _buildSidePageAppBarIcon(context, Icons.keyboard_double_arrow_right_rounded),
    );
  }

  /// Returns a [Padding] widget containing a [Material] widget with an [InkWell] child.
  ///
  /// The [InkWell] widget has a rounded border and is wrapped in a transparent [Material] widget.
  /// When tapped, it triggers the [leave] function to navigate back in the app.
  ///
  /// The [InkWell] contains a [Container] with a rounded border and a background color of
  /// [Theme.of(context).colorScheme.surfaceContainer]. Inside the [Container] is an [Icon] widget
  /// with the provided [icon] parameter, sized according to [SenseiConst.iconSize] and colored
  /// using [Theme.of(context).colorScheme.onSurface].
  Widget _buildSidePageAppBarIcon(BuildContext context, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(SenseiConst.padding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          onTap: () => leave(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Icon(
              icon,
              size: SenseiConst.iconSize,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

