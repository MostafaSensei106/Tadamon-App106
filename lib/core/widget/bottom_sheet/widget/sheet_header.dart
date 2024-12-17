import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class BottomSheetHeader extends StatelessWidget {
  final String titile;
  const BottomSheetHeader({super.key, required, required this.titile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: SenseiConst.margin.h),
            width: 80.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryFixedDim,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Text(
            titile,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
