import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class DilogWatingComponent extends StatelessWidget {
  final String title;
  final String message;

  const DilogWatingComponent({
    super.key,
    required this.title,
    required this.message,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DilogWatingComponent(title: title, message: message);
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
      ),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      semanticLabel: title,
      title: Text(title),
      content: const LinearProgressIndicator(),
    );
  }
}
