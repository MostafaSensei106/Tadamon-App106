import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/donation/widget/donation_sheet_content.dart';
import 'package:tadamon/features/edit_text/widgets/edit_text_sheet_content.dart';
import 'package:tadamon/core/widget/home_tool_component/home_tool_component.dart';
import 'package:tadamon/features/products_scanner/logic/logic/product_scan_bloc/product_scan_cubit.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

  @override
  /// A [StatelessWidget] that builds a row of tools that are commonly used in the app.
  ///
  /// The tools are represented as a [Row] of [HomeToolsComponent] widgets. The
  /// [HomeToolsComponent] is a [StatelessWidget] that displays an [Icon] and a [Text]
  /// widget with a [onTap] callback. The [onTap] callback is called when the
  /// [HomeToolsComponent] is tapped.
  ///
  /// The [HomeToolsComponent] is configured with the following properties:
  ///
  /// - [icon]: The [Icon] to display. The [Icon] is displayed with a color of
  /// [Theme.of(context).colorScheme.onSecondary].
  /// - [title]: The [Text] to display. The [Text] is displayed with a color of
  /// [Theme.of(context).colorScheme.onSecondary].
  /// - [onTapped]: The callback to call when the [HomeToolsComponent] is tapped.
  ///
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      padding: EdgeInsets.all(SenseiConst.padding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocProvider(
              create: (_) => ProductScanCubit(),
              child: BlocBuilder<ProductScanCubit, ProductScanState>(
                  builder: (context, state) {
                return HomeToolsComponent(
                  icon: Icons.qr_code_rounded,
                  title: S.of(context).ScanBarcode,
                  onTapped: () => context
                      .read<ProductScanCubit>()
                      .scanBarcodeCamera(context),
                );
              }),
            ),
            BlocProvider(
              create: (_) => ProductScanCubit(),
              child: BlocBuilder<ProductScanCubit, ProductScanState>(
                builder: (context, state) {
                  return HomeToolsComponent(
                    icon: Icons.image_search_rounded,
                    title: S.of(context).ImageAnalysis,
                    onTapped: () => context
                        .read<ProductScanCubit>()
                        .imageAnalysisScan(context),
                  );
                },
              ),
            ),
            HomeToolsComponent(
                icon: Icons.short_text_outlined,
                title: S.of(context).EditText,
                onTapped: () {
                  HapticFeedback.vibrate();
                  EditTextSheetContent.showEditTextBottomSheet(context);
                }),
            HomeToolsComponent(
                icon: Icons.map_outlined,
                title: S.of(context).PalatineMap,
                onTapped: () {
                  HapticFeedback.vibrate();
                  Navigator.pushNamed(context, Routes.palatineMap);
                }),
            HomeToolsComponent(
              icon: Icons.volunteer_activism_outlined,
              title: S.of(context).Donate,
              onTapped: () {
                HapticFeedback.vibrate();
                DonationSheetContent.showDonationBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
