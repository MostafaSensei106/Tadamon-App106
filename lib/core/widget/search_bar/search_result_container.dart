import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SearchBarResultContainer extends StatelessWidget {
  const SearchBarResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.only(bottom: SenseiConst.padding.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child:Center(child: Text('Result'),),
        ),
      ),
    );
  }
}