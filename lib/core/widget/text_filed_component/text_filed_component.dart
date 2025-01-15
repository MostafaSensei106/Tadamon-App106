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

/// Validates the input value based on the component's configuration.
///
/// Returns the [errorText] if the field is required and the value is null or empty.
/// If the field is numeric, returns an error message if the value is not a valid number.
/// Returns null if the value passes all validations.

  String? _validate(String? value) {
    if (isRequired && (value == null || value.isNotEmpty)) {
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


  /// Builds a [TextFormField] based on the component's configuration.
  //
  /// The input value is validated based on the component's configuration.
  /// If the field is required and the value is null or empty, an error message is displayed.
  /// If the field is numeric, an error message is displayed if the value is not a valid number.
  //
  /// If the component is numeric, the [keyboardType] is set to [TextInputType.number],
  /// otherwise it is set to [TextInputType.text].
  //
  /// When the user taps outside the field, the focus is removed from the field.
  //
  /// The [prefixIcon] is used to display an icon based on the [icon] argument.
  /// The [suffixIcon] is used to display a suffix icon if provided.
  //
  /// The [decoration] is used to customize the appearance of the field.
  /// The [filled] property is set to true, and the [fillColor] is set to the surface color of the theme.
  /// The [focusedBorder] is set to an [OutlineInputBorder] with a primary color border and a width of 0.2.
  /// The [border] is set to an [OutlineInputBorder] with no border and a circular border radius of [SenseiConst.inBorderRadius.r].
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
        errorText: isRequired && (controller.text.isEmpty) ? errorText : null,
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
