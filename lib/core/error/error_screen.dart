import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/lottie_component/lottie_component.dart';

/// This function is used to catch any errors that may occur in the app and show an
/// error screen with a cat animation.
///
/// The error screen is a [Material] widget with a [Center] widget as child,
/// which in turn contains a [Padding] widget with a [Column] widget as child.
///
/// The [Column] widget has two children: a [LottieComponent] widget with a
/// lottie animation of a cat and a text with the error message, and a [Text]
/// widget with the error message.
///
/// The [Text] widget is configured with a [textAlign] of [TextAlign.center],
/// a [style] of [TextStyle] with a [color] of [Colors.grey], and the error
/// message as text.
///
/// The [Material] widget is used to display the error screen when an error
/// occurs.
errorScreen() {
  ErrorWidget.builder = (details) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LottieComponent(
                  lottiePath: SenseiConst.lottieCatErrorAnimation,
                  text: 'حدث خطأ في تطبيق تضامن'),
              const SizedBox(height: 8),
              Text(
                details.exception.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  };
}
