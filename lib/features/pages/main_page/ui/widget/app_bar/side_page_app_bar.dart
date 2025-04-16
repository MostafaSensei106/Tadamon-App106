import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SidePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool useBackButton;
  const SidePageAppBar({
    super.key,
    this.useBackButton = false,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Navigate back in the app by calling [Navigator.pop] on the given [context], and
  /// trigger a haptic feedback with [HapticFeedback.vibrate].
  void leave(context) {
    HapticFeedback.vibrate();
    Navigator.pop(context);
  }

  @override

  /// Returns an [AppBar] widget with a centered title and a leading widget that is a left
  /// arrow icon. When the icon is tapped, it triggers the [leave] function to navigate back in
  /// the app. The [AppBar] has no elevation and a white background.
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor:Theme.of(context).colorScheme.onSurface,
      title: Text(title),
      centerTitle: true,
      forceMaterialTransparency: true,
      leading: useBackButton
          ? _buildSidePageAppBarIcon(
              context, Icons.keyboard_double_arrow_right_rounded)
          : null,
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
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        ),
        padding: const EdgeInsets.all(4),
      ),
      onPressed: () => leave(context),
      icon: Icon(
        icon,
        size: SenseiConst.iconSize,
      ),
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
