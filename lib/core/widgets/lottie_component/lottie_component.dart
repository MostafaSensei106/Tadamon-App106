import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieComponent extends StatelessWidget {
  final String lottiePath;
  final String text;
  const LottieComponent(
      {super.key, required this.lottiePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          lottiePath,
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
          options: LottieOptions(enableMergePaths: true),
        ),
        SizedBox(height: 10.h),
        Text(
          text,
          style: TextStyle(
              fontSize: 16.sp, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
