import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SearchBarResultContainer extends StatelessWidget {
  const SearchBarResultContainer({super.key});

  @override
  /// Returns an [Expanded] widget with a [Padding] widget containing a [Container]
  /// widget with the given properties.
  ///
  /// The [width] is set to [double.infinity] to take up the full width of the
  /// screen.
  ///
  /// The [decoration] is set to a [BoxDecoration] with a [BorderRadius] of
  /// [SenseiConst.outBorderRadius.r] and a [color] of either the
  /// [Theme.of(context).colorScheme.surfaceContainer] or [Colors.transparent] if
  /// [useColor] is set to false.
  ///
  /// The [child] is a [Center] widget with a [Text] widget containing the string
  /// 'Result'.
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.only(bottom: SenseiConst.padding.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child:Center(child: Text('Result'),),
        ),
      ),
    );
  }
}