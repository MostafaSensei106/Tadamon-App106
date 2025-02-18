import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';

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
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
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
          Positioned(
            bottom: 0,
            child: Container(
              width: 1.sw,
              height: 0.10.sh,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Prev'),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotWidth: SenseiConst.indicatorDotSize+3,
                      dotHeight: SenseiConst.indicatorDotSize+3,
                      dotColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha((0.5 * 255).toInt()),
                      activeDotColor: Theme.of(context).colorScheme.primaryContainer,
                      expansionFactor: 2,
                    ),
                    
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

