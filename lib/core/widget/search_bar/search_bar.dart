import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SenseiSearchBar extends StatelessWidget {
  const SenseiSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SenseiConst.padding.h),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              leading: Icon(Icons.search_rounded),
              hintText: 'ابحث هنا',
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.surfaceContainer),
              elevation: WidgetStateProperty.all(0),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SenseiConst.outBorderRadius))),
              onChanged: (value) {},
              onSubmitted: (value) {},
              onTap: () {
                HapticFeedback.vibrate();
              },
            ),
          ),
          SizedBox(width: 6.w),
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius.r),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: DropdownButton<String>(
              elevation: 0,
              enableFeedback: true,
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius.r),
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              underline: Container(),
              onChanged: (value) {},
              items: const [
                DropdownMenuItem(
                  value: 'الأحدث',
                  child: Text('الأحدث'),
                ),
                DropdownMenuItem(
                  value: 'الأقدم',
                  child: Text('الأقدم'),
                ),
                DropdownMenuItem(
                  value: 'الأقل سعرا',
                  child: Text('الأقل سعرا'),
                ),
                DropdownMenuItem(
                  value: 'الأعلى سعرا',
                  child: Text('الأعلى سعرا'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
