import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/barcode_scanner/data/repo/fire_store_services.dart';
import 'package:tadamon/features/barcode_scanner/logic/logic/logic.dart';
import 'package:tadamon/features/barcode_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/components/home_tool_components.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

  Future<void> _scanBarcodeAndShowProductInfo(BuildContext context) async {
    String resSerialNumber = await ScanerManger().scanBarcode(context);
    if (!context.mounted) return;
    if (!context.mounted) return;
    final product = await FireStoreServices().getProductBySerialNumber(resSerialNumber);
    if (!context.mounted) return;
    ModelBottomSheet.show(
      context,
      S.of(context).SheetTitleProductInfo,
      child: ProductListView(
      product: product,
      ),
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
              onTapped: () => _scanBarcodeAndShowProductInfo(context),
            ),
            HomeToolsComponent(
              icon: Icons.image_search_rounded,
              title: S.of(context).ImageAnalysis,
              onTapped: () {},
            ),
            HomeToolsComponent(
              icon: Icons.short_text_outlined,
              title: S.of(context).EditText,
              onTapped: () {},
            ),

            HomeToolsComponent(
              icon: Icons.map_outlined,
              title: S.of(context).PalatineMap,
              onTapped: () {},
            ),
            HomeToolsComponent(
              icon: Icons.volunteer_activism_outlined,
              title: S.of(context).Donate,
              onTapped: () {},
            ),
          ],
        ),
      ),
    );
  }
}
