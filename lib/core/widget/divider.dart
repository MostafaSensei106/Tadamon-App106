import 'package:flutter/material.dart';

class SenseiDivider extends StatelessWidget {
  const SenseiDivider({super.key});

  @override

  /// Returns a [Divider] widget with a thickness, height, indent, and endIndent of
  /// 0, and a color of [Theme.of(context).colorScheme.outline] with an opacity
  /// of 0.8.
  
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.1,
      height: 0,
      indent: 0,
      endIndent: 0,
      color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
    );
  }
  
}
