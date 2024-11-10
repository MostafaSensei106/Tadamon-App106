import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/generated/l10n.dart';

class GoogleNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer.withOpacity(0.9),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SenseiConst.padding.w,
              vertical: SenseiConst.padding.w,
            ),
            child: GNav(
              tabBorderRadius: SenseiConst.inBorderRadius.r,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.w,
              ),
              curve: Curves.easeInOut,
              tabs: [
                GButton(
                  icon: currentIndex == 0
                      ? Icons.house_rounded
                      : Icons.house_outlined,
                  iconSize: SenseiConst.iconSize,
                  iconColor: theme.colorScheme.onSecondaryContainer,
                  text: S.of(context).Home,
                ),
                GButton(
                  icon: currentIndex == 1 ? Icons.search : Icons.manage_search,
                  iconSize: SenseiConst.iconSize,
                  iconColor: theme.colorScheme.onSecondaryContainer,
                  text: S.of(context).Search,
                ),
                GButton(
                  icon: currentIndex == 2
                      ? Icons.landslide_outlined
                      : Icons.insights_rounded,
                  iconSize: SenseiConst.iconSize,
                  iconColor: theme.colorScheme.onSecondaryContainer,
                  text: S.of(context).Logs,
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
