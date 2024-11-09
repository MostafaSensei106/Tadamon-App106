import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon_app/core/widget/appBar/custom_app_bar_clipper.dart';

class SenseiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SenseiAppBar({
    super.key,
    required this.title,
  });

  final String title;

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
          elevation: 0,
          actions: const [],
          title: Text(title),
        ),
      ),
    );
  }
}
