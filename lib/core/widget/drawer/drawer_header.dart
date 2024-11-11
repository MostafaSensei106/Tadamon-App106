import 'package:flutter/material.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                SenseiConst.drawerImage,
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low),
        ),
        child: null);
  }
}
