import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/fonts/fonts.dart';
import 'package:tadamon/core/extensions/date_format_extension.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';

class ProductLogsExpansionTileComponent extends StatelessWidget {
  final ScannedLogsProductModel product;
  const ProductLogsExpansionTileComponent({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      ),
      child: ExpansionTile(
        leading: product.trusted
            ? Container(
                padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh),
                child: const Icon(
                  Icons.check_circle_outline_outlined,
                  size: SenseiConst.iconSize,
                ))
            : Container(
                padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh),
                child: const Icon(
                  Icons.block_rounded,
                  size: SenseiConst.iconSize,
                )),
        title: Text(product.name),
        subtitle: Text(product.serialNumber,style: AppTextStyle.subtitle(context),),
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
            subtitle: product.name,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.business_rounded,
            title: "الشركة المصنعة",
            subtitle: product.manufacture,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.category_outlined,
            title: "التصنيف",
            subtitle: product.category,
            useDivider: true,
          ),
          DrawerComponent(
            leadingIcon: Icons.handshake_outlined,
            title: "الحالة",
            useDivider: true,
            subtitle: product.onError == "Product not found"
                ? "المنتج غير موجود"
                : product.trusted
                    ? "مؤمن"
                    : "غير مؤمن",
          ),
          DrawerComponent(
            leadingIcon: Icons.date_range_outlined,
            title: "التاريخ",
            subtitle: product.scannedAt.formatted,
          ),
        ],
      ),
    );
  }

  
}
