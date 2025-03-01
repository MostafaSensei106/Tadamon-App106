import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class HomeToolsComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTapped;

  const HomeToolsComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          enableFeedback: true,
          onTap: onTapped,
          child: Container(
            padding: EdgeInsets.all(3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(SenseiConst.padding.w),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    icon,
                    size: SenseiConst.iconSize.sp,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: SenseiConst.padding.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

