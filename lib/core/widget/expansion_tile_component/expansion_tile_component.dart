// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tadamon/core/config/const/sensei_const.dart';

class ExpansionTileComponent extends StatefulWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const ExpansionTileComponent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  State<ExpansionTileComponent> createState() => _ExpansionTileComponentState();
}

class _ExpansionTileComponentState extends State<ExpansionTileComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
      ),
      child: ExpansionTile(
        leading: Container(
            padding: EdgeInsets.all(SenseiConst.padding.w),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SenseiConst.inBorderRadius.r),
                color: Theme.of(context).colorScheme.surfaceContainerHigh),
            child: Icon(
              widget.leadingIcon,
              size: SenseiConst.iconSize,
            )),
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        enableFeedback: true,
        showTrailingIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
          ),
        ),
        children: widget.children,
      ),
    );
  }
}
