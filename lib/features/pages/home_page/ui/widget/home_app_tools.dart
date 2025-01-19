import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/components/home_tool_components.dart';
import 'package:tadamon/features/products_scanner/logic/logic/product_scan_bloc/product_scan_cubit.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

  @override
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
                    onTapped: () => context.read<ProductScanCubit>().imageAnalysisScan(context),
                  );
                },
              ),
            ),
            HomeToolsComponent(
                icon: Icons.short_text_outlined,
                title: S.of(context).EditText,
                onTapped: () {
                  HapticFeedback.vibrate();
                  AppToast.showToast('سوف تتوافر قريبا');
                }),
            HomeToolsComponent(
              icon: Icons.map_outlined,
              title: S.of(context).PalatineMap,
              onTapped: () {
                HapticFeedback.vibrate();
                AppToast.showToast('سوف تتوافر قريبا');
              },
            ),
            HomeToolsComponent(
              icon: Icons.volunteer_activism_outlined,
              title: S.of(context).Donate,
              onTapped: () {
                HapticFeedback.vibrate();
                AppToast.showToast('سوف تتوافر قريبا');
              },
            ),
          ],
        ),
      ),
    );
  }
}
