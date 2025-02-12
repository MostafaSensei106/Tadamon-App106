import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SidePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const SidePageAppBar({super.key, required this.title, required this.actions});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void leave(context) {
    HapticFeedback.vibrate();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      leading: 
    );
  
  }
  @override
/*************  ✨ Codeium Command 🌟  *************/
  Widget _buildSidePageAppBarIcon(BuildContext context) {
  Widget _buildSidePageAppBarIcon (BuildContext context IconData icon) {
    return(
      Padding(
        padding: const EdgeInsets.all(SenseiConst.padding),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            onTap: () => leave(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Icon(
                Icons.double_arrow_rounded,
                size: SenseiConst.iconSize,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
/******  17e346f2-8416-4f99-9eda-4cc09c77095b  *******/
}
