import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/lottie_component/lottie_component.dart';

errorScreen() {
  ErrorWidget.builder = (details) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieComponent(
                  lottiePath: SenseiConst.lottieCatErrorAnimation,
                  text: details.exception.toString()),
              const SizedBox(height: 8),
              Text(
                details.exception.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // يمكنك تنفيذ إعادة تشغيل التطبيق هنا
                },
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  };
}
