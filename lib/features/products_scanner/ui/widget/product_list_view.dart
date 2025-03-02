import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/widget/drawer_component/drawer_component.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

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
          useGroupTop: true,
          useDivider: true,
          useinBorderRadius: true,
          leadingIcon: Icons.qr_code_rounded,
          title: "الرقم التسلسلي",
          subtitle: product.serialNumber,
          trailingWidget: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => {
              HapticFeedback.vibrate(),
              Clipboard.setData(ClipboardData(text: product.serialNumber))
            },
          ),
        ),
        DrawerComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.label_outline_rounded,
          title: "إسم المنتج",
          subtitle: product.name,
        ),
        DrawerComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.business_rounded,
          title: "المصنع",
          subtitle: product.manufacture,
        ),
        DrawerComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.category_outlined,
          title: "التصنيف",
          subtitle: product.category,
        ),
        DrawerComponent(
          useGroupBottom: true,
          useinBorderRadius: true,
          leadingIcon: Icons.handshake_outlined,
          title: "الحالة",
          subtitle: product.onError == "Product not found" ? "المنتج غير موجود" : product.trusted ? "مؤمن" : "غير مؤمن",
        ),
      ],
    );
  }
}
