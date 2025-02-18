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
  late Timer _autoSlideTimer;

  final List<String> _imageUrls = [
    'https://cdnuploads.aa.com.tr/uploads/Contents/2023/10/21/thumbs_b_c_f90d9d191fa2cd8c00d134bc30ba251f.jpg?v=110742',
  ];

  int _currentPage = 0;

  @override

  /// Initializes the state of the widget.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// It initializes the page controller and starts the auto slide timer.
  void initState() {
    super.initState();
    _initializeSlider();
  }

  /// Initializes the page controller and sets up the automatic image slider.
  ///
  /// This function creates a [PageController] starting at the initial page and
  /// starts an auto-slide timer. It also adds a listener to the page controller
  /// to update the current page state when the page changes.

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

  /// Starts the automatic image slider.
  ///
  /// This function creates a periodic timer that triggers the next page to be
  /// displayed every [_autoSlideDuration]. When the last page is displayed, the
  /// timer triggers the first page to be shown again. The page transition is
  /// animated with a duration of [_slideTransitionDuration] and a curve of
  /// [Curves.easeInOut].
  ///
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

  /// Returns a [CachedNetworkImage] widget that displays the image at the given
  /// [imageUrl].
  ///
  /// The widget is configured with a [BoxFit.cover] fit, a progress indicator
  /// that shows the download progress, a medium filter quality, and an error
  /// widget that displays an error message if the image fails to load.
  ///
  /// The error widget is a container with a color of
  /// [Theme.of(context).colorScheme.surfaceContainerHigh], and a child of a
  /// column with an [Icon] and a [Text] widget. The icon is an
  /// [Icons.image_not_supported_outlined] icon with a color of
  /// [Theme.of(context).colorScheme.error] and a size of [SenseiConst.iconSize].
  /// The text is a string that says " " (Failed to download the image).
  ///
  /// The [useOldImageOnUrlChange] property is set to true, so that the same
  /// image is used when the URL changes. This is useful if the image is updated
  /// without changing its URL.
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
            Icon(Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.error,
                size: SenseiConst.iconSize),
            Text('فشل تحميل الصورة'),
          ],
        ),
      ),
      useOldImageOnUrlChange: true,
    );
  }

  /// Returns a [Padding] widget containing a [SmoothPageIndicator].
  ///
  /// The [SmoothPageIndicator] is configured to display page indicators for the
  /// images using an [ExpandingDotsEffect]. The number of indicators is set to
  /// the length of the [_imageUrls] list.
  ///
  /// The effect has dots with a width and height of [_indicatorDotSize], a dot
  /// color with an alpha of 0.5, and an active dot color from the theme's
  /// primary container. The expansion factor for the active dot is set to 2.
  ///
  /// The [onDotClicked] callback animates the page controller to the selected
  /// page with a duration of [_slideTransitionDuration] and a curve of
  /// [Curves.easeInOut].

  Widget _buildPageIndicator() {
    return Padding(
      padding:  EdgeInsets.only(bottom:SenseiConst.padding.h),
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
            expansionFactor: 2,),
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
    _pageController.removeListener(() {});
    _pageController.dispose();

    _autoSlideTimer.cancel();

    super.dispose();
  }
}
