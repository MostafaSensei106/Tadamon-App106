import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class HomeToolsComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTapped;

  const HomeToolsComponent(
      {super.key,
      required this.icon,
      required this.title,
       this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        enableFeedback: true,

        onTap: onTapped,
        child: SizedBox(
          width: 0.23.sw,
          height: 0.20.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              Text(
                textAlign: TextAlign.center,
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
