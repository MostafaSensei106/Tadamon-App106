import 'package:share_plus/share_plus.dart';

class ShareServices {
  static void share(String url) {
    Share.share(url);
  }
}