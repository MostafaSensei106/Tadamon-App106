import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/core/config/theme/colors/logic/theme_cubit.dart';
import 'package:tadamon_app/core/config/theme/colors/logic/theme_state.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, bool>(
      selector: (state) => state.isDark,
      builder: (context, isDark) {
        return DrawerHeader(
          padding: EdgeInsets.zero,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
            child: Container(
              key: ValueKey<bool>(isDark),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isDark
                        ? SenseiConst.drawerImageDark
                        : SenseiConst.drawerImageLight,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SenseiConst.outBorderRadius.r),
                  topRight: Radius.circular(SenseiConst.outBorderRadius.r),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
