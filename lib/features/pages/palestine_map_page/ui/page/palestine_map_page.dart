import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/app_bar/side_page_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

class PalestineMapPage extends StatelessWidget {
  const PalestineMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SidePageAppBar(title: S.of(context).PalatineMap,),
      body: InteractiveViewer(
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(SenseiConst.outBorderRadius.r), topRight: Radius.circular(SenseiConst.outBorderRadius.r)),
          child: SvgPicture.asset(
            SenseiConst.palestineMap,
            fit: BoxFit.cover,
            placeholderBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: SenseiConst.iconSize,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ في تحميل الصورة',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
