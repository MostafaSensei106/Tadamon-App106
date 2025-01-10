import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:flutter/services.dart';
class ActionDrawerIcon extends StatelessWidget {
  const ActionDrawerIcon({super.key});

  void openDrawer(context) {
    HapticFeedback.vibrate();
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 17.r, bottom: 8.r),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          onTap: () => openDrawer(context),
          child: _ActionDrawerContainer(
            child: _ActionDrawerIcon(),
          ),
        ),
      ),
    );
  }
}

class _ActionDrawerContainer extends StatelessWidget {
  final Widget child;

  const _ActionDrawerContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        color:
            Theme.of(context).colorScheme.surfaceContainerHigh.withAlpha((0.3 * 255).toInt()),
      ),
      child: child,
    );
  }
}

class _ActionDrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.more_vert_rounded,
      size: SenseiConst.iconSize.sp,
    );
  }
}
