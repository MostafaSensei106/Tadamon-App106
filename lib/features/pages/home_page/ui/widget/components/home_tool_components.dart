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
  /// Returns a [Material] widget with a transparent color and an [InkWell]
  /// widget as child.
  //
  /// The [InkWell] widget is configured with a rounded border with the
  /// [SenseiConst.inBorderRadius] radius, an [onTap] callback that calls
  /// [onTapped], and a child [SizedBox] widget.
  //
  /// The [SizedBox] widget has a width of 0.23 of the screen width and a
  /// height of 0.20 of the screen width.
  //
  /// The [SizedBox] widget has a [Column] widget as child, which is
  /// vertically centered.
  //
  /// The [Column] widget has a [Container] widget as first child, which is
  /// configured with a rounded border with the
  /// [SenseiConst.inBorderRadius] radius, a padding of [SenseiConst.padding]
  /// around it, and a background color of
  /// [Theme.of(context).colorScheme.primaryContainer]. The [Container]
  /// widget has an [Icon] widget as child, which is configured with the
  /// given [icon], a size of [SenseiConst.iconSize], and a color of
  /// [Theme.of(context).colorScheme.onPrimaryContainer].
  //
  /// The [Column] widget has a [SizedBox] widget as second child, which has a
  /// height of 5 logical pixels.
  //
  /// The [Column] widget has a [Text] widget as third child, which is
  /// configured with the given [title], a maximum of 2 lines, and an
  /// [overflow] of [TextOverflow.ellipsis]. The [Text] widget is
  /// horizontally centered.
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
                      BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Icon(
                  icon,
                  size: SenseiConst.iconSize.sp,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
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
