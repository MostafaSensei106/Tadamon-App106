import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/search_bar_component/search_bar.dart';
import 'package:tadamon/core/widget/search_bar_component/search_result_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SenseiConst.padding.w,
      ),
      child: Column(
        children: [
          SenseiSearchBar(),
          SearchBarResultContainer()
        ],
      ),
    );
  }
}