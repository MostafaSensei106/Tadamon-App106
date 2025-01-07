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
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const DrawerComponent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingWidget,
    this.onTapped,
    this.selected = false,
    this.iconSize = SenseiConst.iconSize,
    this.titleStyle,
    this.subtitleStyle,
    this.useMargin,
    this.iconColor,
    this.textColor,
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
                leading: Icon(
                  leadingIcon,
                  color: iconColor ?? Theme.of(context).iconTheme.color,
                  size: SenseiConst.iconSize.sp,
                ),
                title: Text(
                  title,
                  style: titleStyle?.copyWith(color: textColor) ??
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: textColor,
                          ),
                ),
                subtitle: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitleTextStyle: subtitleStyle?.copyWith(color: textColor),
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
