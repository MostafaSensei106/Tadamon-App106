import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieComponent extends StatelessWidget {
  final String lottiePath;
  final String text;
  const LottieComponent(
      {super.key, required this.lottiePath, required this.text});

  @override
  /// Returns a [Column] widget with a [Lottie.asset] widget and a [Text]
  /// widget as children. The [Lottie.asset] widget is configured with the
  /// given [lottiePath], and a width and height of 200 logical pixels. The
  /// [Text] widget is configured with the given [text], and a font size of
  /// 16 logical pixels, and a color of the primary color of the theme.
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
