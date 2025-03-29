import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';

class GoogleNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const GoogleNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  bool _isVisible = true;

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return widget.currentIndex == 0 ? Icons.house_rounded : Icons.house_outlined;
      case 1:
        return Icons.search;
      case 2:
        return widget.currentIndex == 2 ? Icons.update_rounded : Icons.update;
      default:
        throw ArgumentError('Invalid index: $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onDoubleTap: () {
        HapticFeedback.vibrate();
        setState(() => _isVisible = !_isVisible);
      },
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 350),
        firstCurve: const Interval(0.0, 0.5, curve: Curves.easeIn),
        secondCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
        sizeCurve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
        crossFadeState: _isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SenseiConst.padding.w,
            vertical: SenseiConst.padding.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius.r),
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
              child: Material(
                color: Colors.transparent,
                child: GNav(
                  iconSize: SenseiConst.iconSize,
                  tabBackgroundColor: theme.colorScheme.primaryContainer,
                  activeColor: theme.colorScheme.onPrimaryContainer,
                  color: theme.colorScheme.onSurface,
                  tabBorderRadius: SenseiConst.inBorderRadius.r,
                  curve: Curves.easeIn,
                  padding: EdgeInsets.symmetric(
                    horizontal: SenseiConst.padding.w + 5,
                    vertical: SenseiConst.padding.h + 3,
                  ),
                  tabs: [
                    GButton(
                      icon: _getIcon(0),
                      iconSize: SenseiConst.iconSize.sp,
                      text: S.of(context).home,
                    ),
                    GButton(
                      icon: _getIcon(1),
                      iconSize: SenseiConst.iconSize,
                      text: S.of(context).search,
                    ),
                    GButton(
                      icon: _getIcon(2),
                      iconSize: SenseiConst.iconSize,
                      text: S.of(context).logs,
                    ),
                  ],
                  selectedIndex: widget.currentIndex,
                  onTabChange: widget.onItemTapped,
                ),
              ),
            ),
          ),
        ),
        secondChild: Container(
          width: double.infinity,
          height: 75.h,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
