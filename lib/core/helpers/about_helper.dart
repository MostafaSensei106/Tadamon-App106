import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/textbutton_component/textbutton_component.dart';
import 'package:tadamon/generated/l10n.dart';

void appAbout(BuildContext context) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      ),
      title: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            width: 45.w,
            height: 45.w,
            SenseiConst.tadamonAppImage,
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
            ),
          ],
        )
      ]),
      content: Container(
        padding: EdgeInsets.all(SenseiConst.padding.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Text(
          'تم تطوير هذا ',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
      actions: <Widget>[
        TextButtonComponent(
          icon: Icons.close,
          onpressed: () => Navigator.pop(context),
          text: S.of(context).close,
          isClose: true,
        ),

        ///show license
        TextButtonComponent(
          icon: Icons.difference_outlined,
        
          onpressed: () {
            showLicensePage(
              context: context,
              applicationName: 'تطبيق تضامن',
              applicationLegalese:
                  'تم تطوير هذا التطبيق من اجل دعم القضية الفلسطينية',
              applicationIcon: Container(
                padding: EdgeInsets.all(SenseiConst.padding.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius:
                        BorderRadius.circular(SenseiConst.outBorderRadius.r),
                    border: Border.all(
                      color:
                          Theme.of(context).colorScheme.outline.withAlpha(0x80),
                    )),
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.inBorderRadius.r),
                    child: Image.asset(
                        width: 100, height: 100, SenseiConst.tadamonAppImage)),
              ),
              applicationVersion: 'v${SenseiConst.appVersion}',
              useRootNavigator: true,
            );
          },
          text: 'الترخيص',
        ),
      ],
    ),
  );
}
