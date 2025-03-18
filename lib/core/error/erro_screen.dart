import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/lottie_component/lottie_component.dart';

/// A function that returns a default error screen that will be displayed
/// whenever an error occurs in the application. The error screen is a
/// Material widget that displays a column with a cat error animation and
/// a text message that describes the error. The text message is centered
/// and is displayed in a grey color. The screen is displayed in the
/// center of the screen with a padding of 20.0 on all sides.
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
