import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

void appAbout(BuildContext context) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            width: 45.w,
            height: 45.w,
            SenseiConst.senseiImage,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'v${SenseiConst.appVersion}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        )
      ]),
      content: Container(
        padding: EdgeInsets.all(8.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0.r),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Text(
          'S.of(context).AboutApp',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            showLicensePage(context: context);
          },
          child: Text(
            'License',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
