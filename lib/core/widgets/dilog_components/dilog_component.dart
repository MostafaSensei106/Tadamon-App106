import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class DilogComponent extends StatelessWidget {
  final String title;
  final String massage;
  final IconData icon;
  final List<Widget> actions;

  const DilogComponent(
      {super.key,
      required this.title,
      required this.massage,
      required this.actions,
      required this.icon});

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DilogComponent(
          title: title,
          massage: massage,
          actions: actions,
          icon: icon,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      icon: Icon(
        icon,
        size: SenseiConst.iconSize,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      ),
      title: Text(title),
      content: Container(
        padding: const EdgeInsets.all(SenseiConst.padding),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r)),
        child: Text(massage),
      ),
      actions: actions,
    );
  }
}
