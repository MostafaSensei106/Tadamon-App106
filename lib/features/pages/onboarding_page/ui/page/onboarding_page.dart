import 'package:flutter/material.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/animated_triangles.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/dot_indicator_nav.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/onboarding_page_one.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/onboarding_page_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedTriangles(),
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            children: [
              OnboardingPageOne(),
              OnboardingPageTwo(
                firstIcon: Icons.qr_code_rounded,
                secondIcon: Icons.image_search_rounded,
                firstTitle: 'فحص الباركود',
                secondTitle: 'تحليل الصور',
                subtitle:
                    "اكشف عن المنتجات باستخدام الكاميرا أو حلل الصور بتقنية تعلّم الآلة.",
              ),
              OnboardingPageTwo(
                firstIcon: Icons.search_rounded,
                secondIcon: Icons.new_releases_outlined,
                firstTitle: 'ابحث عن المنتج',
                secondTitle: 'اعثر على البدائل',
                subtitle:
                    'ابحث عن المنتجات واحصل علي البدائل للمنتجات المقاطعة بكل سهولة.', 
              ),

            ],
          ),
          DotIndicatorNav(pageController: _pageController),
        ],
      ),
    );
  }
}
