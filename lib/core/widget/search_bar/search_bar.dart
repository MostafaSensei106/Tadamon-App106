import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SenseiSearchBar extends StatelessWidget {
  const SenseiSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: SenseiConst.padding.h),
      child: SearchBar(
        leading: Icon(Icons.search_rounded),
        hintText: 'ابحث هنا',
        backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.surfaceContainer),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius))),
        onChanged: (value) {},
        onSubmitted: (value) {},
      ),
    );
  }
}
