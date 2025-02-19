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

  /// A [ListView] widget that displays a list of [DrawerComponent] widgets.
  /// Each [DrawerComponent] widget is configured with a title, subtitle, and
  /// trailing widget. The [DrawerComponent] widget is used to display a single
  /// item in the list. The [ListView] widget is used to display the list of
  /// items. The [ListView] widget has a [shrinkWrap] property set to true, and
  /// a [physics] property set to [NeverScrollableScrollPhysics], so that the
  /// list is not scrollable. The [ListView] widget is used as a child of a
  /// [SingleChildScrollView].
  ///
  /// The [DrawerComponent] widgets are used to display the product name, serial
  /// number, manufacturer, category, and status. The [DrawerComponent] widgets
  /// are configured with a [leadingIcon], [title], [subtitle], and
  /// [trailingWidget]. The [trailingWidget] is used to display a copy icon, and
  /// when the icon is tapped, it copies the product serial number to the
  /// clipboard. The [DrawerComponent] widgets are also configured with a
  /// [useGroupTop], [useGroupMiddle], and [useGroupBottom] property, which is
  /// used to group the [DrawerComponent] widgets together. The
  /// [useinBorderRadius] property is used to set the border radius of the
  /// [DrawerComponent] widgets. The [useDivider] property is used to set the
  /// divider between the [DrawerComponent] widgets.
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
          subtitle: product.productName,
        ),
        DrawerComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.business_rounded,
          title: "المصنع",
          subtitle: product.productManufacturer,
        ),
        DrawerComponent(
          useGroupMiddle: true,
          useDivider: true,
          leadingIcon: Icons.category_outlined,
          title: "التصنيف",
          subtitle: product.productCategory,
        ),
        DrawerComponent(
          useGroupBottom: true,
          useinBorderRadius: true,
          leadingIcon: Icons.handshake_outlined,
          title: "الحالة",
          subtitle: product.onError == "Product not found" ? "المنتج غير موجود" : product.isTrusted ? "مؤمن" : "غير مؤمن",
        ),
      ],
    );
  }
}
