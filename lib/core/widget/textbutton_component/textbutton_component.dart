import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  final String text;
  final void Function() onpressed;
  final IconData icon;

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.onpressed, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon),
      onPressed: onpressed,
      label: Text(text),
    );
  }
}
