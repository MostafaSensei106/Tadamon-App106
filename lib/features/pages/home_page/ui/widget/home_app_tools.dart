import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/data/models/product_model.dart';
import 'package:tadamon/features/barcode_scanner/data/repository/fire_store_services.dart';
import 'package:tadamon/features/barcode_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/barcode_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/components/home_tool_components.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});


/// Scans a barcode using the camera, retrieves the associated product information,
/// and displays it in a bottom sheet if the context is still mounted and the scan is successful.
///
/// The function triggers a haptic feedback at the start. It attempts to scan a barcode
/// using the camera through `ScannerManager`. If the scan is unsuccessful or the context is
/// no longer mounted, it returns early. Upon successfully obtaining a serial number, it fetches
/// the product details from Firestore using the serial number. If the context remains mounted,
/// it shows the product information in a modal bottom sheet. In case of any errors during
/// the process, an error toast is displayed with the error message.
///
/// Parameters:
/// - `context`: The current build context.

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

  ///
  /// Shows a [ModelBottomSheet] with [ProductListView] as its content. The
  /// [ProductListView] is given a [ProductModel] that is retrieved from
  /// [FireStoreServices] with the serial number that is result of
  /// [ScannerManager.imageAnalysisScan].
  ///
  /// The [HapticFeedback.vibrate] is called at the start of this function.
  ///
  /// or the serial number is null, the function will return without doing
  /// anything.
  ///

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

  
  

/// Builds a horizontal scrolling row of [HomeToolsComponent] widgets wrapped in a [Container].
/// The [Container] has a top margin and padding defined by [SenseiConst], and a background
/// color from the theme's color scheme. It also has rounded corners with a radius defined by
/// [SenseiConst].
///
/// The child [Row] contains multiple [HomeToolsComponent] widgets that represent different
/// actions such as scanning a barcode, image analysis, editing text, viewing a map, and donating.
/// Each component is associated with a specific icon and title, and invokes a corresponding
/// callback when tapped.


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
