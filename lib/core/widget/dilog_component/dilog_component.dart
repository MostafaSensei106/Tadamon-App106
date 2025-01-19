// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DilogComponent extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions;
  final bool useAction = false;

  const DilogComponent({
    super.key,
    required this.title,
    required this.message,
    this.actions,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DilogComponent(title: title, message: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: useAction ? actions : null,
    );
  }

}
