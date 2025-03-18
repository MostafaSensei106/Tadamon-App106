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
            strokeAlign: BorderSide.strokeAlignOutside,
            color: theme.colorScheme.outline.withAlpha(0x80),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SenseiConst.padding.w,
            vertical: SenseiConst.padding.h,
          ),
          child: GNav(
            iconSize: SenseiConst.iconSize,
            tabBackgroundColor: theme.colorScheme.primaryContainer,
            activeColor: theme.colorScheme.onPrimaryContainer,
            color: theme.colorScheme.onSurface,
            tabBorderRadius: SenseiConst.inBorderRadius.r,
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(
              horizontal: SenseiConst.padding.w+5,
              vertical: SenseiConst.padding.h+3,
            ),
            tabs: [
              GButton(
                icon: currentIndex == 0
                    ? Icons.house_rounded
                    : Icons.house_outlined,
                iconSize: SenseiConst.iconSize.sp,
                text: S.of(context).home,
              ),
              GButton(
                icon: Icons.search,
                iconSize: SenseiConst.iconSize,
                text: S.of(context).search,
              ),
              GButton(
                icon:
                    currentIndex == 2 ? Icons.update_rounded : Icons.update,
                iconSize: SenseiConst.iconSize,
                text: S.of(context).logs,
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
