// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';

class OnboardingPageTwo extends StatefulWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final String firstTitle;
  final String secondTitle;
  final String subtitle;
  final bool appOnlineRun;
  final double height;

  const OnboardingPageTwo({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    required this.firstTitle,
    required this.secondTitle,
    required this.subtitle,
    this.appOnlineRun = false,
     this.height = 0.0,
  });

  @override
  State<OnboardingPageTwo> createState() => _OnboardingPageTwoState();
}

class _OnboardingPageTwoState extends State<OnboardingPageTwo> {
  bool isFirstIcon = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        setState(() {
          isFirstIcon = !isFirstIcon;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: widget.height.h),
        Container(
          padding: EdgeInsets.all(SenseiConst.padding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
            ),
          ),
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SenseiConst.inBorderRadius.r),
                color: const Color(0xfffef2e2)),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFirstIcon ? widget.firstIcon : widget.secondIcon,
                key: ValueKey<bool>(isFirstIcon),
                size: 150.sp,
                color: const Color(0xff1e1e22),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          children: [
            AnimatedCrossFade(
              firstChild: Text(
                widget.firstTitle,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              secondChild: Text(
                widget.secondTitle,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              crossFadeState: isFirstIcon
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 350),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
                ),
              ),
            ),
            if (widget.appOnlineRun) ...[
              ButtonCompnent(
                useInBorderRadius: false,
                useWidth: true,
                width: 0.5.sw,
                label: 'تشغيل الاونلاين',
                icon: Icons.cloud_download_outlined,
                onPressed: () {
                  HapticFeedback.vibrate();
                  // context.read<HiveCubit>().fetchDataFromFireStore();
                },
              ),
            ]
          ],
        ),
      ],
    );
  }
}
