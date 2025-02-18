
import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class OnboardingPageIntro extends StatelessWidget {
  const OnboardingPageIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        ClipRRect(
          child: Image.asset(SenseiConst.tadamonAppImage),
        )
      ],
    );
  }
}