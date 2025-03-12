import 'package:flutter/material.dart';
import 'package:tadamon/generated/l10n.dart';

class AppLocalization {
  static late S setLocalization;

  static void initLocalization(BuildContext context) {
    setLocalization = S.of(context);
  }

//   static bool isInitialized() {
//     // ignore: unnecessary_null_comparison
//     return appLocalizations != null;
//   }
// }
}