import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class ButtonCompnent extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool? isEnabled;

  const ButtonCompnent({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isEnabled = true,
  });
  @override
  Widget build(BuildContext context) {
  /// A component that displays an elevated button with an icon and a label.
  ///
  /// The button is displayed with a width of [double.infinity] and is centered
  /// horizontally.
  ///
  /// The button is displayed with the elevation of 2, and the icon is displayed
  /// with a size of [SenseiConst.iconSize.sp].
  ///
  /// The button's background color is set to [Theme.of(context).colorScheme.primaryContainer],
  /// and the foreground color is set to [Theme.of(context).colorScheme.onPrimaryContainer].
  ///
  /// The button's disabled background color is set to [Theme.of(context).colorScheme.error],
  /// and the disabled foreground color is set to [Theme.of(context).colorScheme.onError].
  ///
  /// The button's disabled icon color is set to [Theme.of(context).colorScheme.onError].
  ///
  /// The button's padding is set to [EdgeInsets.symmetric(horizontal: SenseiConst.padding.w,
  /// vertical: SenseiConst.padding.h)].
  ///
  /// The button's shape is set to [RoundedRectangleBorder.circular(SenseiConst.inBorderRadius.r)].
  ///
  /// The button's enable feedback is set to true.
  ///
  /// The button's enabled mouse cursor is set to [WidgetStateMouseCursor.clickable].
  ///
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled! ? onPressed : null,
        icon: Icon(
          icon,
          size: SenseiConst.iconSize.sp,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      
          disabledBackgroundColor: Theme.of(context).colorScheme.error,
          disabledForegroundColor: Theme.of(context).colorScheme.onError, 
      
          disabledIconColor: Theme.of(context).colorScheme.onError,
      
          padding: EdgeInsets.symmetric(
            horizontal: SenseiConst.padding.w,
            vertical: SenseiConst.padding.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          ),
          elevation: 2,
          enableFeedback: true,
          enabledMouseCursor: WidgetStateMouseCursor.clickable,
          
          ),
      ),
    );
  }
}
