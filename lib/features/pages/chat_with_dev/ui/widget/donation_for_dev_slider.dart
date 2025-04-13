import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class DonationForDevSlider extends StatefulWidget {
  const DonationForDevSlider({super.key});

  @override
  State<DonationForDevSlider> createState() => _DonationForDevSliderState();
}

class _DonationForDevSliderState extends State<DonationForDevSlider> {
  static const Duration _autoSlideDuration = Duration(seconds: 3);
  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);

  late final PageController _pageController;
  Timer? _autoSlideTimer;

  final List<String> _imagesPaths = [
    SenseiConst.buyMeACoffeeImage,
    SenseiConst.waterMelonCoverImage,
    SenseiConst.drawerImage,
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initializeSlider();
  }

  void _initializeSlider() {
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();

    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
      if (!mounted) return;

      if (_currentPage < _imagesPaths.length - 1) {
        _pageController.nextPage(
          duration: _slideTransitionDuration,
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: _slideTransitionDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  void _resumeAutoSlide() {
    _startAutoSlide();
  }

  Widget _buildImageSlide(String imageAsset) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(SenseiConst.inBorderRadius)),
      child: Image.asset(
        imageAsset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.error,
                size: SenseiConst.iconSize,
              ),
              const Text('فشل تحميل الصورة'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: SenseiConst.padding.h),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _imagesPaths.length,
        effect: ExpandingDotsEffect(
          dotWidth: SenseiConst.indicatorDotSize,
          dotHeight: SenseiConst.indicatorDotSize,
          dotColor: Theme.of(context)
              .colorScheme
              .onSurface
              .withAlpha((0.5 * 255).toInt()),
          activeDotColor: Theme.of(context).colorScheme.primaryContainer,
          expansionFactor: 2,
        ),
        onDotClicked: (index) {
          _pageController.animateToPage(
            index,
            duration: _slideTransitionDuration,
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pauseAutoSlide(),
      onTapUp: (_) => _resumeAutoSlide(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: SenseiConst.padding),
            child: AspectRatio(
              aspectRatio: 30 / 10, 
              child: PageView.builder(
                controller: _pageController,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: _imagesPaths.length,
                itemBuilder: (context, index) =>
                    _buildImageSlide(_imagesPaths[index]),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
              ),
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }
}
