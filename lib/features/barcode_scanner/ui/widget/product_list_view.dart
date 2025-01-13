import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/widget/drawer/drawer_component.dart';
import 'package:tadamon/features/barcode_scanner/data/mode/product_model.dart';

class ProductListView extends StatelessWidget {
  final ProductModel? product;

  const ProductListView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DrawerComponent(
            useGroupTop: true,
            useDivider: true,
            leadingIcon: Icons.qr_code_rounded,
            title: "الرقم التسلسلي",
            subtitle: product!.serialNumber,
            trailingWidget: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => {
                Clipboard.setData(ClipboardData(text: product!.serialNumber))
              },
            ),
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.label_outline_rounded,
            title: "إسم المنتج",
            subtitle: product!.productName ?? "لا يوجد",
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.business_rounded,
            title: "الشركة المصنعة",
            subtitle: product!.productManufacturer ?? "لا يوجد",
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.category_outlined,
            title: "التصنيف",
            subtitle: product!.productCategory ?? "لا يوجد",
          ),
          DrawerComponent(
            useGroupBottom: true,
              leadingIcon: Icons.handshake_outlined,
              title: "الحالة",
              subtitle:
                  (product!.isTrusted ?? false) ? 'لا يدعم الكيان' : 'مقاطعة'),
        ],
      );
  }
}
