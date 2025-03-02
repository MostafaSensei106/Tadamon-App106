import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/app_bar/action_drawer_icons.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/app_bar/app_bar_title.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SenseiAppBar(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(SenseiConst.appBarImage),
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: const [
          ActionDrawerIcon(),
        ],
        title: AppBarTitle(title: title),
      ),
    );
  }
}
