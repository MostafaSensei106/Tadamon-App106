import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a black background and white text.
  static void showSimpleToastInfo(String message) {
    toastification.show(
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 1),
      dragToClose: true,
      pauseOnHover: true,
      style: ToastificationStyle.simple,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      padding: const EdgeInsets.all(SenseiConst.padding),
      backgroundColor: AppRouter.theme.onSurface,
      primaryColor: AppRouter.theme.primary,
      foregroundColor: AppRouter.theme.onPrimary,
      borderSide: BorderSide(
        color: AppRouter.theme.outline.withAlpha(0x80),
      ),
      // ignore: deprecated_member_use
      closeButtonShowType: CloseButtonShowType.none,
    );
  }

  /// Shows a toast with the given [message] for a long duration at the bottom of
  /// the screen with a red background and white text.
  static void showErrorToast(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      autoCloseDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.info_outline,
        size: SenseiConst.iconSize,
      ),
      padding: const EdgeInsets.all(SenseiConst.padding),
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
      dragToClose: true,
      // ignore: deprecated_member_use
      closeButtonShowType: CloseButtonShowType.none,
    );
  }

  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a green background and white text.

  static void showSuccessToast(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 1),
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      icon: const Icon(
        Icons.info_outline,
        size: SenseiConst.iconSize,
      ),
      padding: const EdgeInsets.all(SenseiConst.padding),
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
      showProgressBar: false,
      dragToClose: true,
      // ignore: deprecated_member_use
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
