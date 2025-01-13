import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/divider.dart';

class DrawerComponent extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Widget? trailingWidget;
  final VoidCallback? onTapped;
  final bool selected;
  final bool? useMargin;
  final bool? useSingeGroup;
  final bool? useGroupTop;
  final bool? useGroupMiddle;
  final bool? useGroupBottom;
  final bool? useDivider;

  const DrawerComponent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingWidget,
    this.onTapped,
    this.selected = false,
    this.useMargin,
    this.useDivider,
    this.useGroupTop,
    this.useGroupMiddle,
    this.useGroupBottom,
    this.useSingeGroup,
  });

  BorderRadius _getBorderRadius() {
    if (useGroupTop ?? false) {
      return BorderRadius.only(
        topLeft: Radius.circular(SenseiConst.outBorderRadius.r),
        topRight: Radius.circular(SenseiConst.outBorderRadius.r),
      );
    } else if (useGroupBottom ?? false) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(SenseiConst.outBorderRadius.r),
        bottomRight: Radius.circular(SenseiConst.outBorderRadius.r),
      );
    } else if (useSingeGroup ?? false) {
      return BorderRadius.circular(SenseiConst.outBorderRadius.r);
    } else if (useGroupMiddle ?? false) {
      return BorderRadius.zero;
    }
    return BorderRadius.circular(SenseiConst.outBorderRadius.r);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: useMargin ?? false
          ? const EdgeInsets.only(top: SenseiConst.margin)
          : null,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: _getBorderRadius(),
              enableFeedback: true,
              customBorder: RoundedRectangleBorder(
                borderRadius: _getBorderRadius(),
              ),
              onTap: onTapped,
              child: ListTile(
                horizontalTitleGap: 13.w,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: SenseiConst.padding.w,
                    vertical: 0
                ),
                leading: Container(
                       padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                  child: Icon(
                    leadingIcon,
                    size: SenseiConst.iconSize.sp,
                  ),
                ),
                title: Text(
                  title,
                ),
                subtitle: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: trailingWidget,
                selected: selected,
              ),
            ),
          ),
          if (useDivider ?? false) const SenseiDivider(),
        ],
      ),
    );
  }
}
