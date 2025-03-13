import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/dilog_components/dilog_component.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbutton_component.dart';
import 'package:tadamon/features/counter_manager/widget/home_items_counter.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_app_tools.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/home_tip.dart';
import 'package:tadamon/features/pages/home_page/ui/widget/image_news.dart';
import 'package:tadamon/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SenseiConst.padding),
        child: Column(
          children: [
            const HomeTip(),
            const ImageNews(),
            const HomeAppTools(),
            const ItemsCounter(),
            ButtonCompnent(
              label: 'test',
              icon: Icons.text_snippet_outlined,
              onPressed: () => DilogComponent(
                title: 'اختبار',
                massage: 'اختبار لبرمجة هذا التطبيق',
                actions: [
                  TextButtonComponent(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                    text: S.of(context).close,
                    isClose: true,
                  ),
                  TextButtonComponent(
                    icon: Icons.text_snippet_outlined,
                    text: 'text',
                    onTap: () {
                      AppToast.showToast(' يعمل بنجاح ');
                    },
                  )
                ],
                icon: Icons.access_time,
              ).show(context),
            ),
          ],
        ),
      ),
    );
  }
}
