import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class ProductExpansionTile extends StatelessWidget {
  final ProductModel product;

  const ProductExpansionTile({super.key, required this.product});
    @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.qr_code_rounded),
      title: Text(product.productName),
      subtitle: Text(product.serialNumber),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      enableFeedback: true,
      showTrailingIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 0.2,
        ),
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.qr_code_rounded),
          title: Text(product.productName),
          subtitle: Text(product.serialNumber),
        ),
        ListTile(
          leading: const Icon(Icons.label_outline_rounded),
          subtitle: Text(product.productName),
        ),
        ListTile(
          leading: const Icon(Icons.business_rounded),
          subtitle: Text(product.productManufacturer),
        ),
        ListTile(
          leading: const Icon(Icons.category_outlined),
          subtitle: Text(product.productCategory),
        ),
        ListTile(
          leading: const Icon(Icons.handshake_outlined),
          subtitle: Text(product.isTrusted ? 'مقاطعة' : 'لا يدعم الكيان'),
        ),
      ],
    );
  }
}
