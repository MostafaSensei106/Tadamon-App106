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
  static const double _indicatorDotSize = 8.0;
  late final PageController _pageController;
  late Timer _autoSlideTimer;

  final List<String> _imageUrls = [
    'https://scontent.fcai21-4.fna.fbcdn.net/v/t39.30808-6/397935802_2018437758522158_2569968800478949291_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=ykvD8Y3sJWYQ7kNvgHpdbQP&_nc_oc=AdiO3rK_DeC4TlyfVA2jDSknshuLqw8Ww_hKATkiCjZMlVVplMUFdAyomjBkcCY-YkY&_nc_zt=23&_nc_ht=scontent.fcai21-4.fna&_nc_gid=ANrTu2YOCUHmD8X6uj6TmAJ&oh=00_AYBbcyGPdqRZ71R5LmIrNB7WBa-8NEM6fBF6toQ7J0IBrw&oe=678F3867',
    'https://scontent.fcai21-4.fna.fbcdn.net/v/t39.30808-6/310423213_1747668878932382_1507469300678917103_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_ohc=r_ZR3tGZKrMQ7kNvgE5HgLY&_nc_oc=AdhR_E3B4DgpBEPu3pN0as1vJGgk-FzVJulEP0BcKXDzohPpqtzjJvpPDFt4oc0iYpE&_nc_zt=23&_nc_ht=scontent.fcai21-4.fna&_nc_gid=AIRo0kRsbmhILln82EP4yjA&oh=00_AYD3NWmdf0bWa6gxdi54d3Q_y8S5vygfHP8n_pEgFOPROg&oe=678F2C93',
        

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

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: _imageUrls.length,
        effect: ExpandingDotsEffect(
          dotWidth: _indicatorDotSize,
          dotHeight: _indicatorDotSize,
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
    _pageController.dispose();

    super.dispose();
  }
}
