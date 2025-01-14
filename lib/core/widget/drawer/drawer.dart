import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_cubit.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_state.dart';
import 'package:tadamon/core/helpers/about_helper.dart';
import 'package:tadamon/core/helpers/dev_helper.dart';
import 'package:tadamon/core/helpers/theme_toggle_helper.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widget/drawer/drawer_component.dart';
import 'package:tadamon/core/widget/drawer/drawer_header.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';
import 'package:tadamon/generated/l10n.dart';

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
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    _buildThemeSwitch(context),
                    _buildModeSwitch(context),
                    _buildAppOffline(context),
                    _buildEnableOnline(context),
                    _buildClearLogs(context),
                    _buildHowToUse(context),
                    _buildReportProduct(context),
                    _buildReportBug(context),
                    _buildDeveloper(context),
                    _buildAbout(context),
                  ],
                ),
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
            HapticFeedback.vibrate();
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
        return state.themeMode == ThemeMode.system
            ? const SizedBox.shrink()
            : DrawerComponent(
                key: ValueKey(state.isDark),
                useGroupBottom: true,
                leadingIcon: state.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: state.isDark
                    ? S.of(context).DarkTheme
                    : S.of(context).LightTheme,
                subtitle: state.isDark
                    ? S.of(context).SwitchToLightTheme
                    : S.of(context).SwitchToDarkTheme,
                trailingWidget: Switch(
                  value: state.isDark,
                  onChanged: (bool value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                ),
                onTapped: () {
                  HapticFeedback.vibrate();

                  context.read<ThemeCubit>().toggleTheme(!state.isDark);
                },
                useMargin: false,
                useDivider: false,
              );
      },
    );
  }

  Widget _buildAppOffline(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.offline_bolt_outlined,
      title: S.of(context).AppOffLine,
      subtitle: S.of(context).AppOffLineMassage,
      trailingWidget: Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
      ),
    );
  }

  Widget _buildEnableOnline(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.dataset_outlined,
      title: S.of(context).EnableOnline,
      subtitle: S.of(context).EnableOnlineMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.pop(context);
      },
    );
  }

  Widget _buildClearLogs(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: false,
      useSingeGroup: true,
      leadingIcon: Icons.clear_all_rounded,
      title: S.of(context).clearLogs,
      subtitle: S.of(context).clearLogsMassage,
      onTapped: () {
        HapticFeedback.vibrate();

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("سوف تتوفر في أقرب وقت ممكن"),
          ),
        );
      },
    );
  }

  Widget _buildHowToUse(BuildContext context) {
    return DrawerComponent(
        useMargin: true,
        useDivider: true,
        useGroupTop: true,
        leadingIcon: Icons.question_answer_outlined,
        title: S.of(context).HowToUse,
        subtitle: S.of(context).HowToUseMassage,
        onTapped: () {
          HapticFeedback.vibrate();

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("سوف تتوفر في أقرب وقت ممكن"),
          ));
        });
  }

  Widget _buildReportProduct(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: true,
      useGroupMiddle: true,
      leadingIcon: Icons.production_quantity_limits_outlined,
      title: S.of(context).ReportProduct,
      subtitle: S.of(context).ReportProductMassage,
      onTapped: () {
        HapticFeedback.vibrate();

        Navigator.pop(context);
        ModelBottomSheet.show(context, 'بلغ عن منتج',
            child: ReportProductSheetContent());
      },
    );
  }

  Widget _buildReportBug(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.bug_report_outlined,
      title: S.of(context).ReportBug,
      subtitle: S.of(context).ReportBugMassage,
      trailingWidget: Text(S.of(context).Test),
      onTapped: () {
        HapticFeedback.vibrate();

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("سوف تتوفر في أقرب وقت ممكن"),
          ),
        );
      },
    );
  }

  // Widget _buildShareApp(BuildContext context) {}

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
