import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

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
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(
          right: SenseiConst.margin,
          left: SenseiConst.margin,
          bottom: SenseiConst.margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white30,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(
            Radius.circular(SenseiConst.outBorderRadius)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
            Radius.circular(SenseiConst.outBorderRadius)),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.9),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SenseiConst.padding,
                  vertical: SenseiConst.padding),
              child: GNav(
                color: theme.colorScheme.onPrimaryContainer,
                tabBorderRadius: SenseiConst.inBorderRadius.r,
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.w),
                tabs: [
                  GButton(
                    icon:
                        currentIndex == 0 ? Icons.image : Icons.image_outlined,
                    iconSize: SenseiConst.iconSize,
                    iconColor: theme.colorScheme.onPrimaryContainer,
                    text: 'Image',
                  ),
                  GButton(
                    icon: currentIndex == 1
                        ? Icons.video_camera_back_rounded
                        : Icons.video_camera_back_outlined,
                    iconSize: SenseiConst.iconSize,
                    iconColor: theme.colorScheme.onPrimaryContainer,
                    text: 'Video',
                  ),
                  GButton(
                    icon: currentIndex == 2
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    iconSize: SenseiConst.iconSize,
                    iconColor: theme.colorScheme.onPrimaryContainer,
                    text: 'Saved',
                  )
                ],
                selectedIndex: currentIndex,
                onTabChange: onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
