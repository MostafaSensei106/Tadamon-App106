import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

class HomeToolsComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTapped;

  HomeToolsComponent(
      {required this.icon, required this.title, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        onTap: onTapped,
        child: Column(
          children: [
            Container(
              width: 50.w,
              height: 40.w,
              padding: EdgeInsets.all(SenseiConst.padding.w),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SenseiConst.outBorderRadius.r),
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.3),
              ),
              child: Icon(
                icon,
                size: SenseiConst.iconSize.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(title),
          ],
        ),
      ),
    );
  }
}
