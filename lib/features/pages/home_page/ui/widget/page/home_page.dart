import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/counter_manager/widget/home_items_counter.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_app_tools.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_tip.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/image_news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override

  /// A stateless widget that builds the home page of the app.
  ///
  /// It is a [SingleChildScrollView] with a [SafeArea] as child. The
  /// [SingleChildScrollView] has a [Padding] widget as child, which
  /// contains a [Column] widget with the [HomeTip], [ImageNews],
  /// [HomeAppTools], and [ItemsCounter] widgets as children.
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
              ItemsCounter(),
            ],
          ),
        ),
      ),
    );
  }
}
