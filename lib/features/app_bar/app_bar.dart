import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/app_bar/action_drawer_icons.dart';
import 'package:tadamon/features/app_bar/app_bar_title.dart';
import 'package:tadamon/features/app_bar/custom_app_bar_clipper.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SenseiAppBar(this.title, {super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.h);

  @override
  /// Returns a [ClipPath] widget with a [CustomAppBarClipper] as the
  /// [clipper]. The child of the [ClipPath] widget is a [Container] widget with
  /// a [Decoration] set to a [BoxDecoration] with a [DecorationImage] as the
  /// [image] property. The [DecorationImage] is configured with the
  /// 'assets/images/WaterMelonCover.jpg' image and a [BoxFit] of [BoxFit.cover].
  ///
  /// The child of the [Container] widget is an [AppBar] widget with a
  /// [backgroundColor] of [Colors.transparent], [automaticallyImplyLeading] set
  /// to false, an [elevation] of 0, and an [action] of an [ActionDrawerIcon]
  /// widget. The [title] of the [AppBar] widget is an [AppBarTitle] widget with
  /// the given [title] as the [text] property.
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBarClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(SenseiConst.appBarImage),
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
