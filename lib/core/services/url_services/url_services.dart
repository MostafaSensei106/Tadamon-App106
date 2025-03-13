import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlRunServices {
  /// A function to launch a URL.
  ///
  /// It takes a [String] which is the URL to be launched.
  ///
  /// It will try to launch the URL with [LaunchMode.externalApplication].
  ///
  /// If the launch fails, it will throw an [Exception].
  ///
  /// If an [Exception] is thrown, it will show a toast with the error message.
   static Future<void> launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

}