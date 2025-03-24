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
/// Builds a [TextButton] with an icon and label.
///
/// The button is styled using [TextButton.styleFrom] with a specific shape
/// and background color. The [RoundedRectangleBorder] is used to give the
/// button rounded corners with a radius defined by [SenseiConst.inBorderRadius].
///
/// The button's tap target size is adjusted to shrink wrap.
///
/// If [isClose] is true, the button has a transparent background and a border
/// with a color from the theme's outline; otherwise, it has no border and the
/// background color is set to the theme's primary container color.
///
/// The [text] is displayed as the button's label and the [icon] as its icon.
/// The [onTap] callback is triggered when the button is pressed.

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
