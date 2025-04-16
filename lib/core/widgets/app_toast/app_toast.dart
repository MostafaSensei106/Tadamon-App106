import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a black background and white text.
  static void showSimpleToast(String message) {
    toastification.show(
      style: ToastificationStyle.simple,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(SenseiConst.padding),
      backgroundColor: AppRouter.theme.surface,
      foregroundColor: AppRouter.theme.onSurface,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter, color: Colors.transparent),
      dragToClose: true,
      pauseOnHover: true,
    );
  }

  /// Shows a toast with the given [message] for a long duration at the bottom of
  /// the screen with a red background and white text.
  static void showErrorToast(String discription) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      title: const Text('حدث خطأ'),
      description: Text(discription),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(SenseiConst.padding),
      backgroundColor: AppRouter.theme.surface,
      foregroundColor: AppRouter.theme.onSurface,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter, color: Colors.transparent),
      dragToClose: true,
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static void showWarningToast(String discription) {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      title: const Text('حدث خطأ'),
      description: Text(discription),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(SenseiConst.padding),
      backgroundColor: AppRouter.theme.surface,
      foregroundColor: AppRouter.theme.onSurface,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter, color: Colors.transparent),
      dragToClose: true,
      pauseOnHover: true,
      showProgressBar: true
    );
  }

  /// Shows a toast with the given [message] for a short duration at the bottom
  /// of the screen with a green background and white text.

  static void showSuccessToast(String message) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      backgroundColor: AppRouter.theme.surface,
      foregroundColor: AppRouter.theme.onSurface,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter, color: Colors.transparent),
      dragToClose: true,
      pauseOnHover: true,
    );
  }

  static void showInfoToast(String message) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      backgroundColor: AppRouter.theme.surface,
      foregroundColor: AppRouter.theme.onSurface,
      borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter, color: Colors.transparent),
      dragToClose: true,
      pauseOnHover: true,
      showProgressBar: true
    );
  }
}
