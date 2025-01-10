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
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: theme.colorScheme.outline.withAlpha((0.2 * 255).toInt()),
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
