import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData icon;
  final bool isClose;

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.isClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(text),
      icon: Icon(icon),
      onPressed: onTap,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        ),
        side: isClose
            ? BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(0x80))
            : BorderSide.none,
        backgroundColor: isClose
            ? Colors.transparent
            : Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
