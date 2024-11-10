import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/features/home_page/ui/widget/home_tool_components.dart';
import 'package:tadamon_app/generated/l10n.dart';

//HomeAppRow Tools
class HomeAppTools extends StatelessWidget {
  const HomeAppTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      padding: EdgeInsets.all(SenseiConst.padding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeToolsComponent(
              icon: Icons.qr_code_rounded,
              title: S.of(context).ScanBarcode,
              onTapped: () {},
            ),
            HomeToolsComponent(
              icon: Icons.image_search_rounded,
              title: S.of(context).ImageAnalysis,
              onTapped: () {},
            ),
            HomeToolsComponent(
              icon: Icons.map_outlined,
              title: S.of(context).PalatineMap,
              onTapped: () {},
            ),
            HomeToolsComponent(
              icon: Icons.volunteer_activism_outlined,
              title: S.of(context).Donate,
              onTapped: () {},
            ),
          ],
        ),
      ),
    );
  }
}
