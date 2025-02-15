import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';

class GoogleNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const GoogleNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  /// Returns a [Padding] widget with a [Container] widget as child.
  ///
  /// The [Container] widget has a rounded border with the
  /// [SenseiConst.outBorderRadius] radius, and a background color of
  /// [Theme.of(context).colorScheme.surfaceContainer]. The [Container] widget
  /// also has a thin border with a color of
  /// [Theme.of(context).colorScheme.outline] with an alpha of 0.2.
  ///
  /// The [Container] widget has a [Padding] widget as child, which has a
  /// horizontal padding of [SenseiConst.padding.w] and a vertical padding of
  /// [SenseiConst.padding.w].
  ///
  /// The [Padding] widget has a [GNav] widget as child, which is configured
  /// with the given properties.
  ///
  /// The [GNav] widget has an [iconSize] of [SenseiConst.iconSize], a
  /// [tabBackgroundColor] of [Theme.of(context).colorScheme.primaryContainer],
  /// an [activeColor] of [Theme.of(context).colorScheme.onPrimaryContainer], a
  /// [color] of [Theme.of(context).colorScheme.onSurface], a
  /// [tabBorderRadius] of [SenseiConst.inBorderRadius.r], and a [curve] of
  /// [Curves.easeIn].
  ///
  /// The [GNav] widget has three tabs with icons and text, which are
  /// configured with the given [currentIndex] and [onItemTapped] properties.
  /// 
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SenseiConst.padding.w,
        vertical: SenseiConst.padding.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          color: theme.colorScheme.surfaceContainer,
          border: Border.all(
            width: 0.2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: theme.colorScheme.outline.withAlpha(0x80),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SenseiConst.padding.w,
            vertical: SenseiConst.padding.w,
          ),
          child: GNav(
            iconSize: SenseiConst.iconSize,
            tabBackgroundColor: theme.colorScheme.primaryContainer,
            activeColor: theme.colorScheme.onPrimaryContainer,
            color: theme.colorScheme.onSurface,
            tabBorderRadius: SenseiConst.inBorderRadius.r,
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.w,
            ),
            tabs: [
              GButton(
                icon: currentIndex == 0
                    ? Icons.house_rounded
                    : Icons.house_outlined,
                iconSize: SenseiConst.iconSize.sp,
                text: S.of(context).Home,
              ),
              GButton(
                icon: Icons.search,
                iconSize: SenseiConst.iconSize,
                text: S.of(context).Search,
              ),
              GButton(
                icon:
                    currentIndex == 2 ? Icons.dns_rounded : Icons.dns_outlined,
                iconSize: SenseiConst.iconSize,
                text: S.of(context).Logs,
              ),
            ],
            selectedIndex: currentIndex,
            onTabChange: onItemTapped,
          ),
        ),
      ),
    );
  }
}
