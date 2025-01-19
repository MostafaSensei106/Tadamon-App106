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
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/drawer/drawer_component.dart';
import 'package:tadamon/features/drawer/drawer_header.dart';
import 'package:tadamon/features/products_scanner/logic/logic/hive_bloc/hive_cubit.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';
import 'package:tadamon/generated/l10n.dart';

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  @override

  /// Builds a drawer widget with a specified width and background color derived
  /// from the current theme. The drawer contains a header and a list of settings
  /// options, each constructed by helper methods. The list is wrapped in an
  /// animated size widget, allowing for smooth resizing transitions. The drawer
  /// shape is defined by a continuous rectangle border with a radius specified
  /// in the constants.

  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.90.sw,
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
                    _buildUpdateLocalHiveDataBase(context),
                    _buildDeleteLocalHiveData(context),
                    _buildHowToUse(context),
                    _buildReportProduct(context),
                    _buildClearLogs(context),
                    _buildReadMe(context),
                    _buildLetestUpdate(context),
                    _buildGithubToken(context),
                    _buildTelegramChannel(context),
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

  /// A switch to toggle between light and dark theme based on the system
  /// setting.
  ///
  /// The switch is disabled if the theme mode is not [ThemeMode.system].
  ///
  /// When the switch is toggled, the theme mode is updated by calling
  /// [toggleTheme].
  ///
  /// The switch is wrapped in a [BlocBuilder] to rebuild when the theme mode
  /// changes.
  ///
  /// The switch is wrapped in a [DrawerComponent] with a divider and a group
  /// top if the theme mode is not [ThemeMode.system].
  ///
  /// The switch is wrapped in a [DrawerComponent] with a title of
  /// [S.systemTheme], a subtitle of [S.followSystemTheme], and a leading icon
  /// of [Icons.brightness_auto_outlined].
  ///
  /// When the switch is tapped, the [HapticFeedback.vibrate] is called and the
  /// switch is toggled.
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

  /// A switch to toggle between light and dark theme.
  //
  /// The switch is disabled if the theme mode is [ThemeMode.system].
  //
  /// When the switch is toggled, the theme is updated by calling
  /// [toggleTheme].
  //
  /// The switch is wrapped in a [BlocBuilder] to rebuild when the theme mode
  /// changes.
  //
  /// The switch is wrapped in a [DrawerComponent] with a divider and a group
  /// bottom if the theme mode is not [ThemeMode.system].
  //
  /// The switch is wrapped in a [DrawerComponent] with a title of
  /// [S.darkTheme] or [S.lightTheme], a subtitle of
  /// [S.switchToLightTheme] or [S.switchToDarkTheme], a leading icon of
  /// [Icons.light_mode_outlined] or [Icons.dark_mode_outlined], and a trailing
  /// widget of a [Switch] with the current theme mode.
  //
  /// When the switch is tapped, the [HapticFeedback.vibrate] is called and the
  /// switch is toggled.
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
    return BlocProvider(
      create: (context) => HiveCubit()..hiveHasData(),
      child: BlocBuilder<HiveCubit, HiveState>(
        builder: (context, state) {
          Widget trailingWidget =
              Icon(Icons.query_builder_rounded, color: Colors.red);
          String subtitleText = S.of(context).AppOflineLoading;
          bool groupTop = false;
          if (state is HiveDataBaseHasData) {
            trailingWidget =
                Icon(Icons.check_box_outlined, color: Colors.green);
            subtitleText = S.of(context).AppOnLineMassageRunning;
            groupTop = true;
          } else if (state is HiveDataBaseEmpty) {
            trailingWidget =
                Icon(Icons.error_outline_rounded, color: Colors.red);
            subtitleText = S.of(context).AppOffLineMassageDontRunning;
            groupTop = false;
          } else {
            trailingWidget =
                Icon(Icons.query_builder_rounded, color: Colors.yellow);
            subtitleText = S.of(context).AppOflineLoading;
            groupTop = false;
          }
          return DrawerComponent(
            useMargin: true,
            useDivider: groupTop,
            useGroupTop: groupTop,
            leadingIcon: Icons.offline_bolt_outlined,
            title: S.of(context).AppOffLine,
            subtitle: subtitleText,
            trailingWidget: trailingWidget,
          );
        },
      ),
    );
  }

  Widget _buildEnableOnline(BuildContext context) {
    return BlocProvider(
      create: (context) => HiveCubit()..hiveHasData(),
      child: BlocListener<HiveCubit, HiveState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataFetchingFromFireStore) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('جاري استيراد البيانات'),
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Expanded(
                          child: Text('يرجى الانتظار حتى تكتمل المزامنة...')),
                    ],
                  ),
                );
              },
            );
          }
          if (state is HiveDataFetchingFromFireStoreSuccess) {
            AppToast.showSuccessToast('تم تهيئة البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (state is HiveDataFetchingFromFireStoreFailure) {
            AppToast.showErrorToast('حدث خطأ في استيراد البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<HiveCubit, HiveState>(
          builder: (context, state) {
            if (state is HiveDataBaseEmpty) {
              return ButtonCompnent(
                useMargin: true,
                label: 'تشغيل الاونلاين',
                icon: Icons.dataset_outlined,
                onPressed: () {
                  HapticFeedback.vibrate();
                  context.read<HiveCubit>().fetchDataFromFireStore();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildUpdateLocalHiveDataBase(BuildContext context) {
    return BlocProvider(
      create: (_) => HiveCubit()..hiveHasData(),
      child: BlocListener<HiveCubit, HiveState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataFetchingFromFireStore) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('جاري تحديث قاعدة البيانات'),
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Expanded(
                          child:
                              Text('يرجى الانتظار حتى تكتمل عملية التحديث...')),
                    ],
                  ),
                );
              },
            );
          }
          if (state is 
          HiveDataFetchingFromFireStoreSuccess) {
            AppToast.showSuccessToast('تم تحديث قاعدة البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is HiveDataDeleteFailure) {
            AppToast.showErrorToast('حدث خطاء في تحديث قاعدة البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<HiveCubit, HiveState>(
          builder: (context, state) {
            if (state is HiveDataBaseHasData) {
              return DrawerComponent(
                useDivider: true,
                useGroupMiddle: true,
                leadingIcon: Icons.dataset_linked_outlined,
                title: 'تحديث قاعدة البيانات',
                subtitle: 'تحديث قاعدة البيانات',
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<HiveCubit>().updateDataBaseFromFireStore();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDeleteLocalHiveData(BuildContext context) {
    return BlocProvider(
      create: (_) => HiveCubit()..hiveHasData(),
      child: BlocListener<HiveCubit, HiveState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataBaseDeleting) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('جاري حذف البيانات'),
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Expanded(
                          child:
                              Text('يرجى الانتظار حتى تكتمل عملية الحذف...')),
                    ],
                  ),
                );
              },
            );
          }
          if (state is HiveDataDeleteSuccess) {
            AppToast.showSuccessToast('تم حذف البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is HiveDataDeleteFailure) {
            AppToast.showErrorToast('حدث خطأ في حذف البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<HiveCubit, HiveState>(
          builder: (context, state) {
            if (state is HiveDataBaseHasData) {
              return DrawerComponent(
                useGroupBottom: true,
                leadingIcon: Icons.delete_forever_outlined,
                title: 'حذف البيانات',
                subtitle: 'سوف يتم حذف جميع المنتجات المحفوظة',
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<HiveCubit>().deleteAllLocalProducts();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// A drawer component that clears the logs when tapped.
  /// The component has a margin, no divider, and a single group. The leading icon is
  /// [Icons.clear_all_rounded], the title is [S.clearLogs], the subtitle is
  /// [S.clearLogsMassage], and the trailing widget is null. When the component is tapped,
  /// [HapticFeedback.vibrate] is called, the component is popped from the navigator, and
  /// a [SnackBar] is shown with the text "سوف تتوفر في أقرب وقت ممكن".
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

  /// A drawer component that displays a message when the user wants to know how to use the app.
  ///
  /// The component has a margin, a divider, and a group top. The leading icon is
  /// [Icons.question_answer_outlined], the title is [S.HowToUse], the subtitle is
  /// [S.HowToUseMassage], and the trailing widget is null. When the component is tapped,
  /// [HapticFeedback.vibrate] is called, the component is popped from the navigator, and
  /// a [SnackBar] is shown with the text "سوف تتوفر في أقرب وقت ممكن".
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

  /// A drawer component for reporting a product.
  ///
  /// This component has no margin, no divider, and a group bottom. The leading icon is
  /// [Icons.production_quantity_limits_outlined], the title is [S.ReportProduct], and the
  /// subtitle is [S.ReportProductMassage]. When tapped, it triggers a haptic feedback, pops
  /// the component from the navigator, and displays a bottom sheet with the title 'بلغ عن منتج'
  /// and content from [ReportProductSheetContent].

  Widget _buildReportProduct(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
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

  /// A drawer component for displaying the ReadMe section.
  ///
  /// This component has a margin, a divider, and a group top. The leading icon is
  /// [Icons.description_outlined], the title is [S.ReadMe], and the subtitle is
  /// [S.ReadMeMassage]. When tapped, it triggers a haptic feedback and opens the
  /// URL specified by [SenseiConst.devReadMeLink].

  Widget _buildReadMe(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.description_outlined,
      title: S.of(context).ReadMe,
      subtitle: S.of(context).ReadMeMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        UrlRunServices.launchURL(SenseiConst.devReadMeLink);
      },
    );
  }

  /// A drawer component for displaying the "Letest Update" section.
  ///
  /// This component has no margin, a divider, and a group middle. The leading icon is
  /// [Icons.update_outlined], the title is [S.LetastUpdate], and the subtitle is
  /// [S.LetestUpdateMassage]. When tapped, it triggers a haptic feedback and opens the
  /// URL specified by [SenseiConst.devReleaseAppLink].
  Widget _buildLetestUpdate(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: true,
      useGroupMiddle: true,
      leadingIcon: Icons.update_outlined,
      title: S.of(context).LetastUpdate,
      subtitle: S.of(context).LetestUpdateMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        UrlRunServices.launchURL(SenseiConst.devReleaseAppLink);
      },
    );
  }

  /// A drawer component for displaying the GitHub token section.
  ///
  /// This component has no margin, a divider, and a group middle. The leading icon is
  /// [Icons.live_help_outlined], the title is [S.GithubTiket], and the subtitle is
  /// [S.GithubTiketMassage]. When tapped, it triggers a haptic feedback and opens the
  /// URL specified by [SenseiConst.devGitHubTokenLink].
  Widget _buildGithubToken(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: true,
      useGroupMiddle: true,
      leadingIcon: Icons.live_help_outlined,
      title: S.of(context).GithubTiket,
      subtitle: S.of(context).GithubTiketMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        UrlRunServices.launchURL(SenseiConst.devGitHubTokenLink);
      },
    );
  }

  /// A drawer component for displaying the Telegram channel section.
  ///
  /// This component has no margin, no divider, and a group bottom. The leading icon is
  /// [Icons.telegram_rounded], the title is [S.TelegramChannel], and the subtitle is
  /// [S.TelegramChannelMassage]. When tapped, it triggers a haptic feedback and opens the
  /// URL specified by [SenseiConst.devTelegramLink].
  Widget _buildTelegramChannel(BuildContext context) {
    return DrawerComponent(
        useMargin: false,
        useDivider: false,
        useGroupBottom: true,
        leadingIcon: Icons.telegram_rounded,
        title: S.of(context).TelegramChannel,
        subtitle: S.of(context).TelegramChannelMassage,
        onTapped: () {
          HapticFeedback.vibrate();
          UrlRunServices.launchURL(SenseiConst.devTelegramLink);
        });
  }

  /// A drawer component for displaying the developer section.
  ///
  /// This component has a margin, a divider, and a group top. The leading icon is
  /// [Icons.verified_outlined], the title is [S.Developer], and the subtitle is
  /// [S.MostafaMahmoud]. The trailing widget is an avatar built by [ContactSenseiDev].
  /// When tapped, it triggers the display of a developer dialog.

  Widget _buildDeveloper(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.verified_outlined,
      title: S.of(context).Developer,
      subtitle: S.of(context).MostafaMahmoud,
      trailingWidget: const ContactSenseiDev().buildAvatar(context),
      onTapped: () => const ContactSenseiDev().showDevDialog(context),
    );
  }

  /// A drawer component for displaying the About section.
  ///
  /// This component has no margin, no divider, and a group bottom. The leading icon is
  /// [Icons.info_outline], the title is [S.About], and the subtitle is
  /// [S.AboutTadamon]. When tapped, it triggers the display of the About page.
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
