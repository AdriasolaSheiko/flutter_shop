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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVhN680ZnteEBoFA7-xoahR5-Xpr3rqGQ',
    appId: '1:501214130418:web:43bf9d7bda835dc42be06b',
    messagingSenderId: '501214130418',
    projectId: 'flutter-shop-783b2',
    authDomain: 'flutter-shop-783b2.firebaseapp.com',
    databaseURL: 'https://flutter-shop-783b2-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-shop-783b2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrbQyFXrp0NWtkchp_ErbM0820-cnZkhQ',
    appId: '1:501214130418:android:7ee258ce57dc3f2e2be06b',
    messagingSenderId: '501214130418',
    projectId: 'flutter-shop-783b2',
    databaseURL: 'https://flutter-shop-783b2-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-shop-783b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDV-3G80SFmC873rnG2U3DoenDrONf85bs',
    appId: '1:501214130418:ios:e5a63b422ca223ca2be06b',
    messagingSenderId: '501214130418',
    projectId: 'flutter-shop-783b2',
    databaseURL: 'https://flutter-shop-783b2-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-shop-783b2.appspot.com',
    iosBundleId: 'com.example.flutterShop',
  );
}
