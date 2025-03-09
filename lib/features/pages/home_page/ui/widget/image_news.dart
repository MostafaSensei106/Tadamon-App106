import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageNews extends StatefulWidget {
  const ImageNews({super.key});

  @override
  ImageNewsState createState() => ImageNewsState();
}

class ImageNewsState extends State<ImageNews> {
  static const Duration _autoSlideDuration = Duration(seconds: 3);
  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);

  late final PageController _pageController;
  Timer? _autoSlideTimer;

  final List<String> _imageUrls = [
    'https://cdnuploads.aa.com.tr/uploads/Contents/2023/10/21/thumbs_b_c_f90d9d191fa2cd8c00d134bc30ba251f.jpg?v=110742',
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

      if (_currentPage < _imageUrls.length - 1) {
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

  Widget _buildImageSlide(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      filterQuality: FilterQuality.medium,
      errorWidget: (context, url, error) => Container(
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
      useOldImageOnUrlChange: true,
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: SenseiConst.padding.h),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _imageUrls.length,
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(SenseiConst.padding.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: PageView.builder(
                    controller: _pageController,
                    pageSnapping: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemCount: _imageUrls.length,
                    itemBuilder: (context, index) => _buildImageSlide(_imageUrls[index]),
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                  ),
                ),
              ),
            ),
            _buildPageIndicator(),
          ],
        ),
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