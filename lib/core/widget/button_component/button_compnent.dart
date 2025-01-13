import 'package:flutter/material.dart';

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
    return ElevatedButton.icon(
        onPressed: onPressed, icon: Icon(icon), label: Text(label));
  }
}
