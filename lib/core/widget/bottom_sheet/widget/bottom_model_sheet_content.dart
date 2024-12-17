import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class BottomModelSheetContent extends StatelessWidget {
  const BottomModelSheetContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: child);
  }
}
