import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/features/drawer/drawer_component.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class ProductListView extends StatelessWidget {
  final ProductModel? product;

  const ProductListView({
    super.key,
    required this.product,
  });

  @override
  /// Returns a [ListView] widget with a [shrinkWrap] of true, a
  /// [physics] of [NeverScrollableScrollPhysics], and a list of
  /// [DrawerComponent]s. The first [DrawerComponent] displays the
  /// serial number of the product, the second displays the product
  /// name, the third displays the product manufacturer, the fourth
  /// displays the product category, and the fifth displays the
  /// product status. The status is 'مقاطعة' if the product is
  /// trusted and 'لا يدعم الكيان' if the product is not trusted. The
  /// [DrawerComponent]s are styled with a [useGroupTop],
  /// [useGroupMiddle], and [useGroupBottom] properties set to true
  /// for the first, second, third, fourth, and fifth components
  /// respectively. The [useDivider] property is set to true for the
  /// first, second, third, fourth, and fifth components. The
  /// [leadingIcon] property is set to an [Icon] widget with an
  /// [Icons.qr_code_rounded] icon for the first component, an
  /// [Icon] widget with an [Icons.label_outline_rounded] icon for
  /// the second component, an [Icon] widget with an
  /// [Icons.business_rounded] icon for the third component, an
  /// [Icon] widget with an [Icons.category_outlined] icon for the
  /// fourth component, and an [Icon] widget with an
  /// [Icons.handshake_outlined] icon for the fifth component. The
  /// [title] property is set to a string with the title of the
  /// component, and the [subtitle] property is set to a string with
  /// the subtitle of the component. The [trailingWidget] property is
  /// set to an [IconButton] widget with an [Icon] widget with a
  /// [Icons.copy] icon for the first component, and an [Icon] widget
  /// with a [Icons.copy] icon for the second component. The
  /// [onPressed] property of the [IconButton] is set to a function
  /// that copies the serial number to the clipboard and vibrates the
  /// device.
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
                    HapticFeedback.vibrate(),
                Clipboard.setData(ClipboardData(text: product!.serialNumber))
              },
            ),
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.label_outline_rounded,
            title: "إسم المنتج",
            subtitle: product!.productName,
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.business_rounded,
            title: "المصنع",
            subtitle: product!.productManufacturer,
          ),
          DrawerComponent(
            useGroupMiddle: true,
            useDivider: true,
            leadingIcon: Icons.category_outlined,
            title: "التصنيف",
            subtitle: product!.productCategory,
          ),
          DrawerComponent(
            useGroupBottom: true,
              leadingIcon: Icons.handshake_outlined,
              title: "الحالة",
              subtitle:
                  (product!.isTrusted ) ? 'لا يدعم الكيان' : 'مقاطعة'),
        ],
      );
  }
}
