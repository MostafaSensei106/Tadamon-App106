import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/core/config/theme/colors/logic/theme_cubit.dart';
import 'package:tadamon_app/core/config/theme/colors/logic/theme_state.dart';
import 'package:tadamon_app/core/helpers/about_helper.dart';
import 'package:tadamon_app/core/helpers/dev_helper.dart';
import 'package:tadamon_app/core/helpers/theme_toggle_helper.dart';
import 'package:tadamon_app/core/widget/drawer/drawer_components.dart';
import 'package:tadamon_app/core/widget/drawer/drawer_header.dart';
import 'package:tadamon_app/generated/l10n.dart';

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.85.sw,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 0.25.sh, child: DrawerHeaderWidget()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
              child: Column(
                children: [
                  _buildThemeSwitch(context),
                  _buildModeSwitch(context),
                  _buildDeveloper(context),
                  _buildAbout(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return DrawerComponent(
          useMargin: false,
          useDivider: state.themeMode != ThemeMode.system,
          useGroupTop: state.themeMode != ThemeMode.system,
          leadingIcon: Icons.brightness_auto_outlined,
          title: S.of(context).SystemTheme,
          subtitle: S.of(context).FollowSystemTheme,
          trailingWidget: Switch(
            value: state.themeMode == ThemeMode.system,
            onChanged: (bool value) {
              toggleTheme(value, context);
            },
          ),
          onTapped: () {
            bool newValue = !(state.themeMode == ThemeMode.system);
            toggleTheme(newValue, context);
          },
        );
      },
    );
  }

  Widget _buildModeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) =>
          previous.isDark != current.isDark ||
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        if (state.themeMode == ThemeMode.system) {
          return const SizedBox.shrink();
        }
        return DrawerComponent(
          useGroupBottom: true,
          leadingIcon: state.isDark
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          title:
              state.isDark ? S.of(context).DarkTheme : S.of(context).LightTheme,
          subtitle: state.isDark
              ? S.of(context).SwitchToLightTheme
              : S.of(context).SwitchToDarkTheme,
          trailingWidget: Switch(
            key: ValueKey<bool>(state.isDark),
            value: state.isDark,
            onChanged: (bool value) {
              context.read<ThemeCubit>().toggleTheme(value);
            },
          ),
          onTapped: () {
            context.read<ThemeCubit>().toggleTheme(!state.isDark);
          },
          useMargin: false,
          useDivider: false,
        );
      },
    );
  }

  Widget _buildDeveloper(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.logo_dev_outlined,
      title: S.of(context).Developer,
      subtitle: S.of(context).MostafaMahmoud,
      trailingWidget: const ContactSenseiDev().buildAvatar(context),
      onTapped: () => const ContactSenseiDev().showDevDialog(context),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.info_outline,
      title: S.of(context).About,
      subtitle: S.of(context).AboutTadamon,
      onTapped: () => appAbout(context),
    );
  }
}
