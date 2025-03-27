import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:toastification/toastification.dart';

class AppToast {

  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a black background and white text.
  static void showSimpleToastInfo(String message) {
    toastification.show(
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 2),
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
      animationDuration: const Duration(milliseconds: 350),
      alignment: Alignment.bottomCenter,
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      icon: const Icon(
        Icons.info_outline,
        size: SenseiConst.iconSize,
      ),
      padding: EdgeInsets.all(SenseiConst.padding.w),
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      showProgressBar: false,
      dragToClose: true,
    );
  }

  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a green background and white text.

  static void showSuccessToast(String message) {
    toastification.show(
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      animationDuration: const Duration(milliseconds: 350),
      alignment: Alignment.bottomCenter,
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      icon: const Icon(
        Icons.info_outline,
        size: SenseiConst.iconSize,
      ),
      padding: EdgeInsets.all(SenseiConst.padding.w),
      borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
      showProgressBar: false,
      closeButton: ToastCloseButton(
        buttonBuilder: (context, onClose) => OutlinedButton.icon(
          onPressed: onClose,
          label: const Text('Close'),
          icon: const Icon(Icons.close),
        ),
      ),
      dragToClose: true,
    );
  }
}
