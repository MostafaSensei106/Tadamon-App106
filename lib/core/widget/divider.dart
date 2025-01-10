import 'package:flutter/material.dart';

class SenseiDivider extends StatelessWidget {
  const SenseiDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0,
      height: 0,
      indent: 0,
      endIndent: 0,
      color: Theme.of(context).colorScheme.outline.withAlpha((0.8 * 255).toInt()),
    );
  }
}
