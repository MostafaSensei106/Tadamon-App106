import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/drawer_component/drawer_component.dart';
import 'package:tadamon/features/pages/search_page/data/model/search_product_model.dart';

class ProductExpansionTile extends StatelessWidget {
  final ProductSearchModel product;

  const ProductExpansionTile({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      ),
      child: ExpansionTile(
        leading: product.trusted
            ? Icon(Icons.gpp_good_outlined)
            : Icon(Icons.remove_moderator_outlined),
        title: Text(product.name),
        subtitle: Text(product.serialNumber),
        enableFeedback: true,
        showTrailingIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        children: [
          DrawerComponent(
            leadingIcon: Icons.qr_code_rounded,
            title: "رقم المنتج",
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
            subtitle: product.manufacturer,
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
            subtitle: product.trusted ? "لا يدعم الكيان" : "مقاطعة",
          ),
        ],
      ),
    );
  }
}
