import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/widget/appBar/action_drawer_icons.dart';
import 'package:tadamon_app/core/widget/appBar/app_bar_title.dart';
import 'package:tadamon_app/core/widget/appBar/custom_app_bar_clipper.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SenseiAppBar(this.title, {super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.h);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBarClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/WaterMelonCover.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: const [
            ActionDrawerIcon(),
          ],
          title: AppBarTitle(title: title),
        ),
      ),
    );
  }
}
