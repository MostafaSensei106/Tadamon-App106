import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/counter_manager/widget/components/counter_items_components.dart';
import 'package:tadamon/generated/l10n.dart';

class ItemsCounter extends StatelessWidget {
  const ItemsCounter({super.key});

  @override
  /// Build a widget that displays a row of two [CounterItemsComponent]s.
  ///
  /// The first component displays the number of scanned products, and the second
  /// component displays the number of supported products.
  ///
  /// The title of the first component is [S.scanedProducts] and the title of the
  /// second component is [S.supportedProducts].
  ///
  /// The [getCounter] callback of both components is an empty function that returns
  /// 0, and the [counterStream] of both components is an empty stream.
  ///
  /// The [mainAxisAlignment] of the row is [MainAxisAlignment.spaceAround], and
  /// the [margin] of the row is [EdgeInsets.only(top: SenseiConst.margin.h)].
  ///
  /// The [children] of the row are the two [CounterItemsComponent]s, with a
  /// [SizedBox] with a width of [SenseiConst.margin.w] in between them.
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: CounterItemsComponent(
            icon: Icons.qr_code_rounded,
            title: S.of(context).scanedProducts,
            getCounter: () async => 0,
            counterStream: Stream.empty(),
          )),
          SizedBox(width: SenseiConst.margin.w),
          Expanded(
            child: CounterItemsComponent(
              icon: Icons.checklist_rounded,
              title: S.of(context).supportedProducts,
              getCounter: () async => 0,
              counterStream: Stream.empty(),
            ),
          )
        ],
      ),
    );
  }
}
