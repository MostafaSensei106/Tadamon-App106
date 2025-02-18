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
            },
            children: const [
              OnboardingPage(),
              _OnboardingPageItem(
                color: Color(0xffE9F1FF),
                title: 'Search for a charity',
              ),
              _OnboardingPageItem(
                color: Color(0xffF6F6F6),
                title: 'Donate',
              ),
            ],
          ),
          DotIndicatorNav(pageController: _pageController),
        ],
      ),
    );
  }
}

class _OnboardingPageItem extends StatelessWidget {
  const _OnboardingPageItem({
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicatorNav extends StatefulWidget {
  const DotIndicatorNav({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<DotIndicatorNav> createState() => _DotIndicatorNavState();
}

class _DotIndicatorNavState extends State<DotIndicatorNav> {
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  void _pageListener() {
    final isLastPage = (widget.pageController.page ?? 0).round() == 2;
    if (isLastPage != _isLastPage) {
      setState(() {
        _isLastPage = isLastPage;
      });
    }
  }

  Widget _buildButton(String key, String label, IconData icon, VoidCallback onPressed) {
    return ButtonCompnent(
      key: ValueKey(key),
      label: label,
      icon: icon,
      useWidth: true,
      width: 0.3.sw,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.pageController,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SenseiConst.padding.w,
                vertical: SenseiConst.padding.h),
            child: Container(
              padding: EdgeInsets.all(SenseiConst.padding.w),
              alignment: Alignment.bottomCenter,
              width: 1.sw,
              height: 0.08.sh,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(0X80),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: widget.pageController.page == 0
                        ? _buildButton(
                            'skip',
                            'تخطي',
                            Icons.keyboard_double_arrow_right_rounded,
                            () {
                              if (widget.pageController.page == 0) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.mainPage,
                                  (route) => false,
                                );
                              } else {
                                widget.pageController.previousPage(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          )
                        : _buildButton(
                            'previous',
                            'السابق',
                            Icons.keyboard_double_arrow_right_rounded,
                            () {
                              widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
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
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: _isLastPage
                        ? _buildButton(
                            'start',
                            'بدء',
                            Icons.keyboard_double_arrow_left_rounded,
                            () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.mainPage,
                                (route) => false,
                              );
                            },
                          )
                        : _buildButton(
                            'next',
                            'التالي',
                            Icons.keyboard_double_arrow_left_rounded,
                            () {
                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
