import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/core/widget/drawer/drawer_component.dart';
import 'package:tadamon/features/barcode_scanner/data/mode/product_model.dart';

class ProductListView extends StatelessWidget {
  final ProductModel product;

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
          useDivider: true,
          leadingIcon: Icons.qr_code_rounded,
          title: "الرقم التسلسلي",
          subtitle: product.serialNumber,
          trailingWidget: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: product.productName ?? ''));
              AppToast.showSuccessToast('تم نسخ النص الي الحافظة');
            },
          ),
        ),
        DrawerComponent(
          useDivider: true,
          leadingIcon: Icons.label_outline_rounded,
          title: "إسم المنتج",
          subtitle: product.productName ?? "لا يوجد",
        ),
        DrawerComponent(
          useDivider: true,
          leadingIcon: Icons.business_rounded,
          title: "الشركة المصنعة",
          subtitle: product.productManufacturer ?? "لا يوجد",
        ),
        DrawerComponent(
          useDivider: true,
          leadingIcon: Icons.category_outlined,
          title: "التصنيف",
          subtitle: product.productCategory ?? "لا يوجد",
        ),
        DrawerComponent(
          leadingIcon: Icons.handshake_outlined,
          title: "الحالة",
          subtitle: (product.isTrusted ?? false) ? "مفعل" : "غير مفعل",
        ),
      ],
    );
  }
}
