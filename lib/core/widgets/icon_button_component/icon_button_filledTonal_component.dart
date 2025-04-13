import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/icon_button_component/icon_button_component.dart';

class IconButtonFilledtonalComponent extends IconButtonComponent {
  const IconButtonFilledtonalComponent(
      {super.key, required super.icon, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      icon: Icon(icon),
      onPressed: () => onPressed(),
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(2),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
          ),
        ),
      ),
    );
  }
}
