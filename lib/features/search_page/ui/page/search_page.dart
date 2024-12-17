import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/search_bar/search_bar.dart';
import 'package:tadamon/core/widget/search_bar/search_result_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: SenseiConst.padding.w,
              right: SenseiConst.padding.w,
          ),
        child: Column(
          children: [
            SenseiSearchBar(),
            SearchBarResultContainer()
          ],),
      )
    );
  }
}
