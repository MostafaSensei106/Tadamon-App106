import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final void Function() onpressed;
  final IconData icon;
  final bool isClose;

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.onpressed,
    required this.icon,
    this.isClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        side: isClose
            ? BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(0x80))
            : BorderSide.none,

            backgroundColor: isClose
                ? Theme.of(context).colorScheme.errorContainer
                : Colors.transparent,
      ),
      icon: Icon(icon),
      onPressed: onpressed,
      label: Text(text),
    );
  }
}
