import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/counter_manager/widget/components/counter_items_components.dart';
import 'package:tadamon/generated/l10n.dart';

class ItemsCounter extends StatelessWidget {
  const ItemsCounter({super.key});

  @override
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
