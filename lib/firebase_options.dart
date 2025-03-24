import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['API_KEY_ANDROID'] ?? '',
    appId: dotenv.env['APP_ID_ANDROID'] ?? '',
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    databaseURL: dotenv.env['DATABASE_URL'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
  );

  // static FirebaseOptions ios = FirebaseOptions(
  //   apiKey: dotenv.env['API_KEY_IOS'] ?? '',
  //   appId: dotenv.env['APP_ID_IOS'] ?? '',
  //   messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? '',
  //   projectId: dotenv.env['PROJECT_ID'] ?? '',
  //   databaseURL: dotenv.env['DATABASE_URL'] ?? '',
  //   storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
  //   iosBundleId: dotenv.env['IOS_BUNDLE_ID'] ?? '',
  // );


}
