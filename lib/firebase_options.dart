// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrk8x5srYxS6ZIjtw8sn-YbocbFZMcXYo',
    appId: '1:251801216073:android:9432f68a517c82fea34b98',
    messagingSenderId: '251801216073',
    projectId: 'tadamon-32f59',
    databaseURL: 'https://tadamon-32f59-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tadamon-32f59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAu46Zp9tPCdJbLd7-khtjlqo0yHNV9beQ',
    appId: '1:251801216073:ios:d92330feb78d587aa34b98',
    messagingSenderId: '251801216073',
    projectId: 'tadamon-32f59',
    databaseURL: 'https://tadamon-32f59-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tadamon-32f59.appspot.com',
    iosBundleId: 'com.mhsensei.tadamonApp',
  );
}
