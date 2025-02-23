import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/drawer_component/drawer_component.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';

class ProductLogsExpansionTileComponent extends StatelessWidget {
  final HiveProductModel product;
  const ProductLogsExpansionTileComponent({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      ),
      child: ExpansionTile(
        leading: product.isTrusted
            ? Container(
                padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh),
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  size: SenseiConst.iconSize,
                ))
            : Container(
                padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh),
                child: Icon(
                  Icons.block_rounded,
                  size: SenseiConst.iconSize,
                )),
        title: Text(product.productName),
        subtitle: Text(product.serialNumber),
        enableFeedback: true,
        showTrailingIcon: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
            )),
        children: [
          DrawerComponent(
            leadingIcon: Icons.qr_code_rounded,
            title: "الرقم التسلسلي",
            subtitle: product.serialNumber,
            useGroupTop: true,
            useDivider: true,
            useMargin: false,
            trailingWidget: IconButton(
                onPressed: () => Clipboard.setData(
                    ClipboardData(text: product.serialNumber)),
                icon: const Icon(Icons.copy)),
          ),
          DrawerComponent(
            leadingIcon: Icons.label_outline_rounded,
            title: "اسم المنتج",
            subtitle: product.productName,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.business_rounded,
            title: "الشركة المصنعة",
            subtitle: product.productManufacturer,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.category_outlined,
            title: "التصنيف",
            subtitle: product.productCategory,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.handshake_outlined,
            title: "الحالة",
            subtitle: product.isTrusted ? "لا يدعم الكيان" : "مقاطعة",
          ),
          if (product.isTrusted == false)
            Padding(
                padding: EdgeInsets.only(
                    left: SenseiConst.padding.w,
                    right: SenseiConst.padding.w,
                    bottom: SenseiConst.padding.h),
                child: ButtonCompnent(
                    label: 'منتجات بديلة',
                    icon: Icons.new_releases_outlined,
                    onPressed: () => Navigator.pop(context, product))),
        ],
      ),
    );
  }
}
