import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/barcode_scanner/data/mode/product_model.dart';
import 'package:tadamon/features/barcode_scanner/data/repo/fire_store_services.dart';
import 'package:tadamon/features/barcode_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/barcode_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/components/home_tool_components.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

//Scan BarCode Logic
  Future<void> _scanBarcodeCamera(BuildContext context) async {
    HapticFeedback.vibrate();
    try {
      String? resSerialNumber = await ScannerManager().scanBarcode(context);
      if (!context.mounted ||
          resSerialNumber == null ||
          resSerialNumber == '-1') {
        return;
      }
      final product =
          await FireStoreServices().getProductBySerialNumber(resSerialNumber);
      if (!context.mounted) return;
      ModelBottomSheet.show(
        context,
        S.of(context).SheetTitleProductInfo,
        child: ProductListView(product: product as ProductModel?),
      );
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  //Image Analysis logic
  Future<void> _imageAnalysis(BuildContext context) async {
    HapticFeedback.vibrate();
    String? resSerialNumber = await ScannerManager().imageAnalysisScan(context);
    if (!context.mounted || resSerialNumber == null) return;
    final product =
        await FireStoreServices().getProductBySerialNumber(resSerialNumber);
    if (!context.mounted) return;
    ModelBottomSheet.show(
      context,
      S.of(context).SheetTitleProductInfo,
      child: ProductListView(product: product),
    );
  }

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
            HomeToolsComponent(
              icon: Icons.qr_code_rounded,
              title: S.of(context).ScanBarcode,
              onTapped: () => _scanBarcodeCamera(context),
            ),
            HomeToolsComponent(
              icon: Icons.image_search_rounded,
              title: S.of(context).ImageAnalysis,
              onTapped: () => _imageAnalysis(context),
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
