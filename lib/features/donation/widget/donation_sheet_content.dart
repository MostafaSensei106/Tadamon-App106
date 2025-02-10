import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widget/drawer_component/drawer_component.dart';
import 'package:tadamon/generated/l10n.dart';

class DonationSheetContent extends StatelessWidget {
  const DonationSheetContent({super.key});

  static void showDonationBottomSheet(BuildContext context) {
    ModelBottomSheet.show(
      context,
      S.of(context).Donate,
      child: DonationSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerComponent(
          leadingIcon: Icons.volunteer_activism_outlined,
          title: 'منظمة الانوروا',
          subtitle: 'نبرع هم طريق منظمة الانوروا',
          useDivider: true,
          useGroupTop: true,
          onTapped: () =>
              UrlRunServices.launchURL(SenseiConst.donateByUnrwaLink),
        ),
        DrawerComponent(
            leadingIcon: Icons.mode_night_outlined,
            title: 'الهلال الاحمر الفلسطيني',
            subtitle: 'تبرع عن طريق الهلال الاحمر الفلسطيني',
            useDivider: true,
            useGroupMiddle: true,
            onTapped: () =>
                UrlRunServices.launchURL(SenseiConst.donateByPalestinercsLink)),
        DrawerComponent(
          leadingIcon: Icons.maps_home_work_outlined,
          title: 'بيت الزكاة والصدقات المصري',
          subtitle: 'تبرع عن طريق ابيت الزكاةو الصدقات المصري',
          useDivider: true,
          useGroupMiddle: true,
          useinBorderRadius: true,
          onTapped: () =>
              UrlRunServices.launchURL(SenseiConst.donateByBaitzakatLink),
        ),
        DrawerComponent(
          leadingIcon: Icons.food_bank_outlined,
          title: 'بنك الطعام المصري',
          subtitle: 'تبرع عن طريقة بنك الطعام المصري',
          useinBorderRadius: true,
          useGroupBottom: true,
          onTapped: () =>
              UrlRunServices.launchURL(SenseiConst.donateByEGYFoodBankLink),
        )
      ],
    );
  }
}
