import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_cubit/theme_cubit.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_cubit/theme_state.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_helper/theme_helper.dart';
import 'package:tadamon/core/helpers/about_helper.dart';
import 'package:tadamon/core/helpers/dev_helper.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_helper/theme_toggle_helper.dart';
import 'package:tadamon/core/helpers/localization_helper/localization_helper.dart';

import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/core/services/logs_export/pdf_export_services.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/dilog_component/dilog_component.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/core/widget/drawer_component/drawer_component.dart';
import 'package:tadamon/core/widget/app_drawer/widgets/drawer_header.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';
import 'package:tadamon/features/products_scanner/logic/logic/hive_bloc/hive_cubit.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  WidgetStateProperty<Icon> thumbIcon(BuildContext context) {
    return WidgetStateProperty.resolveWith<Icon>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Icon(Icons.check, color: appThemeData.colorScheme.primary);
      }
      return const Icon(Icons.close);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.90.sw,
      child: Drawer(
        //backgroundColor: appThemeData.colorScheme.surface,
        shape: ContinuousRectangleBorder(
          borderRadius:
              BorderRadius.circular(SenseiConst.outBorderRadius.r + 7),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 0.25.sh, child: const DrawerHeaderWidget()),
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
                    _buildExportLogs(context),
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

  Widget _buildThemeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return DrawerComponent(
          useMargin: false,
          useDivider: state.themeMode != ThemeMode.system,
          useGroupTop: state.themeMode != ThemeMode.system,
          leadingIcon: Icons.brightness_auto_outlined,
          title: AppLocalization.setLocalization.SystemTheme,
          subtitle: AppLocalization.setLocalization.FollowSystemTheme,
          trailingWidget: Switch(
            thumbIcon: thumbIcon(context),
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
                    ? AppLocalization.setLocalization.DarkTheme
                    : AppLocalization.setLocalization.LightTheme,
                subtitle: state.isDark
                    ? AppLocalization.setLocalization.SwitchToLightTheme
                    : AppLocalization.setLocalization.SwitchToDarkTheme,
                trailingWidget: Switch(
                  thumbIcon: thumbIcon(context),
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
      create: (context) => LocalDBCubit()..hiveHasData(),
      child: BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (context, state) {
          Widget trailingWidget =
              const Icon(Icons.query_builder_rounded, color: Colors.red);
          String subtitleText = AppLocalization.setLocalization.AppOflineLoading;
          bool groupTop = false;
          if (state is HiveDataBaseHasData) {
            trailingWidget =
                const Icon(Icons.check_box_outlined, color: Colors.green);
            subtitleText = AppLocalization.setLocalization.AppOnLineMassageRunning;
            groupTop = true;
          } else if (state is HiveDataBaseEmpty) {
            trailingWidget =
                const Icon(Icons.error_outline_rounded, color: Colors.red);
            subtitleText = AppLocalization.setLocalization.AppOffLineMassageDontRunning;
            groupTop = false;
          } else {
            trailingWidget =
                const Icon(Icons.query_builder_rounded, color: Colors.yellow);
            subtitleText = AppLocalization.setLocalization.AppOflineLoading;
            groupTop = false;
          }
          return DrawerComponent(
            useMargin: true,
            useDivider: groupTop,
            useGroupTop: groupTop,
            leadingIcon: state is HiveDataBaseHasData
                ? Icons.cloud_done_outlined
                : Icons.cloud_off_rounded,
            title: AppLocalization.setLocalization.AppOffLine,
            subtitle: subtitleText,
            trailingWidget: trailingWidget,
          );
        },
      ),
    );
  }

  Widget _buildEnableOnline(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalDBCubit()..hiveHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataFetchingFromFireStore) {
            const DilogComponent(
                    title: 'جاري استيراد البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
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
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
          builder: (context, state) {
            if (state is HiveDataBaseEmpty) {
              return ButtonCompnent(
                useMargin: true,
                useInBorderRadius: false,
                label: 'تشغيل الاونلاين',
                icon: Icons.cloud_download_outlined,
                onPressed: () {
                  HapticFeedback.vibrate();
                  context.read<LocalDBCubit>().fetchDataFromFireStore();
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
      create: (_) => LocalDBCubit()..hiveHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataFetchingFromFireStore) {
            const DilogComponent(
                    title: 'جاري تحديث قاعدة البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
          }
          if (state is HiveDataFetchingFromFireStoreSuccess) {
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
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
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
                  context.read<LocalDBCubit>().updateDataBaseFromFireStore();
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
      create: (_) => LocalDBCubit()..hiveHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is HiveDataBaseDeleting) {
            const DilogComponent(
                    title: 'جاري حذف البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
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
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
          builder: (context, state) {
            if (state is HiveDataBaseHasData) {
              return DrawerComponent(
                useGroupBottom: true,
                leadingIcon: Icons.delete_forever_outlined,
                title: 'حذف البيانات',
                subtitle: 'سوف يتم حذف جميع المنتجات المحفوظة',
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<LocalDBCubit>().deleteAllLocalProducts();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildClearLogs(BuildContext context) {
    return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.clear_all_rounded,
      title: AppLocalization.setLocalization.clearLogs,
      subtitle: AppLocalization.setLocalization.clearLogsMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.of(context).pop();
        ObjectboxRepositories().clearTadamonLogsFromLocalDB();
      },
    );
  }

  Widget _buildExportLogs(BuildContext context) {
    return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.picture_as_pdf_rounded,
      title: 'تصدير السجلات',
      subtitle: 'تصطير السجلات علي شكل PDF',
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.of(context).pop();
        PdfExportServices()
            .saveDocument(ObjectboxRepositories().saveLogsTOPDF());
        // ObjectboxRepositories().exportTadamonLogsFromLocalDB();
      },
    );
  }
}

Widget _buildHowToUse(BuildContext context) {
  return DrawerComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.question_answer_outlined,
      title: AppLocalization.setLocalization.HowToUse,
      subtitle: AppLocalization.setLocalization.HowToUseMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.userHelp);
      });
}

Widget _buildReportProduct(BuildContext context) {
  return DrawerComponent(
    useMargin: false,
    useDivider: false,
    useGroupBottom: true,
    leadingIcon: Icons.production_quantity_limits_outlined,
    title: AppLocalization.setLocalization.ReportProduct,
    subtitle: AppLocalization.setLocalization.ReportProductMassage,
    onTapped: () {
      HapticFeedback.vibrate();
      Navigator.pop(context);
      ModelBottomSheet.show(context, 'بلغ عن منتج',
          child: const ReportProductSheetContent());
    },
  );
}

Widget _buildReadMe(BuildContext context) {
  return DrawerComponent(
    useMargin: true,
    useDivider: true,
    useGroupTop: true,
    leadingIcon: Icons.description_outlined,
    title: AppLocalization.setLocalization.ReadMe,
    subtitle: AppLocalization.setLocalization.ReadMeMassage,
    onTapped: () {
      HapticFeedback.vibrate();
      UrlRunServices.launchURL(SenseiConst.devReadMeLink);
    },
  );
}

Widget _buildLetestUpdate(BuildContext context) {
  return DrawerComponent(
    useMargin: false,
    useDivider: true,
    useGroupMiddle: true,
    leadingIcon: Icons.update_outlined,
    title: AppLocalization.setLocalization.LetastUpdate,
    subtitle: AppLocalization.setLocalization.LetestUpdateMassage,
    onTapped: () {
      HapticFeedback.vibrate();
      UrlRunServices.launchURL(SenseiConst.devReleaseAppLink);
    },
  );
}

Widget _buildGithubToken(BuildContext context) {
  return DrawerComponent(
    useMargin: false,
    useDivider: true,
    useGroupMiddle: true,
    leadingIcon: Icons.live_help_outlined,
    title: AppLocalization.setLocalization.GithubTiket,
    subtitle: AppLocalization.setLocalization.GithubTiketMassage,
    onTapped: () {
      HapticFeedback.vibrate();
      UrlRunServices.launchURL(SenseiConst.devGitHubTokenLink);
    },
  );
}

Widget _buildTelegramChannel(BuildContext context) {
  return DrawerComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.telegram_rounded,
      title: AppLocalization.setLocalization.TelegramChannel,
      subtitle: AppLocalization.setLocalization.TelegramChannelMassage,
      onTapped: () {
        HapticFeedback.vibrate();
        UrlRunServices.launchURL(SenseiConst.devTelegramLink);
      });
}

Widget _buildDeveloper(BuildContext context) {
  return DrawerComponent(
    useMargin: true,
    useDivider: true,
    useGroupTop: true,
    leadingIcon: Icons.verified_outlined,
    title: AppLocalization.setLocalization.Developer,
    subtitle: AppLocalization.setLocalization.MostafaMahmoud,
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
    title: AppLocalization.setLocalization.About,
    subtitle: AppLocalization.setLocalization.AboutTadamon,
    onTapped: () => appAbout(context),
  );
}
