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
      color: Theme.of(context).colorScheme.outline.withOpacity(0.8),
    );
  }
}
