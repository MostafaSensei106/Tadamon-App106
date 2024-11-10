import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/features/home_page/ui/widget/home_tip.dart';
import 'package:tadamon_app/features/home_page/ui/widget/image_news.dart';

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
          ],
        ),
      ),
    );
  }
}
