import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/home_page/ui/widget/home_app_tools.dart';
import 'package:tadamon/features/home_page/ui/widget/home_tip.dart';
import 'package:tadamon/features/home_page/ui/widget/image_news.dart';
import 'package:tadamon/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            left: SenseiConst.padding.w,
            right: SenseiConst.padding.w,
            bottom: SenseiConst.padding.h),
        child: Column(
          children: [
            HomeTip(),
            ImageNews(),
            HomeAppTools(),
            SizedBox(height: SenseiConst.margin.h),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                ModelBottomSheet.show(context, S().AppName,
                    child: SizedBox(
                      height: 200.h,
                      width: 200.w,
                      child: Text(S().AppName),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
