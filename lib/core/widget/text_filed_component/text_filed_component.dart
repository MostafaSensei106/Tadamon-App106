import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class TextFiledComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final IconButton? suffixIcon;
  final String hint;
  final String errorText;
  final bool isRequired;
  final bool isNumeric;

  const TextFiledComponent(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hint,
      required this.errorText,
      this.suffixIcon,
      this.isRequired = false,
      this.isNumeric = false});

  /// Validates the input [value] based on the requirements of the text field.
  ///
  /// Returns the [errorText] if the field is required and the input is null or empty.
  /// Returns an error message if the field should be numeric and the input is not a valid number.
  /// Returns null if the input passes validation.
  String? _validate(String? value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return errorText;
    } else if (isNumeric &&
        value != null &&
        value.isNotEmpty &&
        double.tryParse(value) == null) {
      return 'الرجاء ادخال رقم صحيح';
    }
    return null;
  }

  @override


  /// Returns a [TextFormField] widget with the given properties.
  ///
  /// The text field is validated with the [_validate] function, which checks if the
  /// input is not null or empty if the field is required, and if the input is a valid
  /// number if the field should be numeric.
  ///
  /// When the user taps outside of the text field, the focus is lost.
  ///
  /// The text field is filled with the [Theme.of(context).colorScheme.surfaceContainer]
  /// color and has a rounded border with the [SenseiConst.inBorderRadius] radius.
  ///
  /// The cursor color is set to the [Theme.of(context).colorScheme.primary] color.
  ///
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: _validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Theme.of(context).colorScheme.primary,
      cursorRadius: Radius.circular(SenseiConst.inBorderRadius.r),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: SenseiConst.iconSize.sp,
        ),
        hintText: hint,
        errorText: isRequired ? errorText : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 0.2,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        ),
      ),
    );
  }
}
