import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class BottomModelSheetContent extends StatelessWidget {

  final Widget child;
  final bool useColor;
  
  const BottomModelSheetContent({super.key, required this.child, this.useColor = false});
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          color: useColor ? Theme.of(context).colorScheme.surfaceContainer : Colors.transparent,
        ),
        child: SingleChildScrollView(
          child: child));
  }
}
