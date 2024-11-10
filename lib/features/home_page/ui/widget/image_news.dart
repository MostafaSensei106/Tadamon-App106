import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';

class ImageNews extends StatefulWidget {
  const ImageNews({super.key});

  @override
  _ImageNewsState createState() => _ImageNewsState();
}

class _ImageNewsState extends State<ImageNews> {
  static const Duration _autoSlideDuration = Duration(seconds: 2);
  static const Duration _slideTransitionDuration = Duration(milliseconds: 400);
  static const double _indicatorDotSize = 8.0;

  late final PageController _pageController;
  late Timer _autoSlideTimer;

  final List<String> _imageUrls = [
    "https://c4.wallpaperflare.com/wallpaper/843/56/876/night-artwork-futuristic-city-cyberpunk-wallpaper-preview.jpg",
    "https://c4.wallpaperflare.com/wallpaper/682/435/620/naruto-anime-uzumaki-naruto-jiraiya-naruto-shippuuden-hd-wallpaper-preview.jpg",
    "https://c4.wallpaperflare.com/wallpaper/966/951/802/digital-digital-art-artwork-illustration-fantasy-art-hd-wallpaper-preview.jpg",
    "https://c4.wallpaperflare.com/wallpaper/383/154/335/car-khyzyl-saleem-mazda-rx-7-simple-background-wallpaper-preview.jpg",
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

    // Listen to page changes for smooth indicator
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
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

  Widget _buildImageSlide(String imageUrl) {
    return Hero(
      tag: imageUrl,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.error_outline, size: 32),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _imageUrls.length,
        effect: ExpandingDotsEffect(
          dotWidth: _indicatorDotSize,
          dotHeight: _indicatorDotSize,
          dotColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          activeDotColor: Theme.of(context).colorScheme.primary,
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
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  controller: _pageController,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _imageUrls.length,
                  itemBuilder: (context, index) =>
                      _buildImageSlide(_imageUrls[index]),
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
    );
  }

  @override
  void dispose() {
    _autoSlideTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }
}
