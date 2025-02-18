import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

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
      elevation: 0,
      icon: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        child: const Icon(
          Icons.info_outline_rounded,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withAlpha(0x80)),
      ),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      semanticLabel: title,
      title: Text(title),
      content: const LinearProgressIndicator(),
      actions: useAction ? actions : null,
    );
  }
}
