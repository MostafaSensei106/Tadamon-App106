import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';

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
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (index) {
              if (index == 1 || index == 0 || index == 2) {
                FocusScope.of(context).unfocus();
              }
              setState(() {});
            },
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Tadamon',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.onSecondary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Search for a charity',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Donate',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          DotIndicator(pageController: _pageController),
        ],
      ),
    );
  }
}

class DotIndicator extends StatefulWidget {
  const DotIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  bool get _isLastPage => widget.pageController.page == 2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(SenseiConst.padding.w),
        alignment: Alignment.bottomCenter,
        width: 1.sw,
        height: 0.08.sh,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonCompnent(
              label: 'تخطي',
              icon: Icons.keyboard_double_arrow_right_rounded,
              useWidth: true,
              width: 0.3.sw,
              onPressed: _isLastPage
                  ? null
                  : () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
            ),
            SmoothPageIndicator(
                controller: widget.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotWidth: SenseiConst.indicatorDotSize,
                  dotHeight: SenseiConst.indicatorDotSize,
                  dotColor: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha((0.5 * 255).toInt()),
                  activeDotColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  expansionFactor: 2,
                ),
                onDotClicked: (index) {
                  widget.pageController.animateToPage(
                    index,
                    duration: SenseiConst.animationDuration,
                    curve: Curves.easeInOut,
                  );
                }),
            Directionality(
              textDirection: TextDirection.ltr,
              child: ButtonCompnent(
                label: _isLastPage ? 'بدء' : 'التالي',
                icon: Icons.keyboard_double_arrow_left_rounded,
                useWidth: true,
                width: 0.3.sw,
                onPressed: _isLastPage
                    ? () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.mainPage,
                          (route) => false,
                        );
                      }
                    : () {
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
