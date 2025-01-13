
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class TextFiledComponent extends StatelessWidget {
  final TextEditingController controller; 
  final IconData icon;
  final Widget suffixIcon;
  final String label;  
  final String hint;
  final String errorText;
  final bool isRequired;

  const TextFiledComponent({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    required this.hint,
    required this.errorText,
    this.suffixIcon = const SizedBox(),
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: controller.text.isNotEmpty && controller.text == controller.text, 
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.primary,
      cursorRadius: Radius.circular(SenseiConst.inBorderRadius.r),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,  
        hintText: hint,
        errorText: isRequired && controller.text.isEmpty ? errorText : null,  
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
        ),
      ),
    );
  }
}
