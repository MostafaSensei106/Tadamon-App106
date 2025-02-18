import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tadamon/core/config/const/sensei_const.dart';

class OnboardingPageTwo extends StatefulWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final String firstTitle;
  final String secondTitle;
  final String subtitle;
  const OnboardingPageTwo({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    required this.firstTitle,
    required this.secondTitle,
    required this.subtitle,
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(SenseiConst.padding.w),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
              ),
            ),
            child: Container(
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
          SizedBox(height: 25.h),
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
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

