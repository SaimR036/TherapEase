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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD4eUj1ACWMpyos66ChoLC76nVk8YFl-3g',
    appId: '1:744230371015:web:2746217244473fb373c8e2',
    messagingSenderId: '744230371015',
    projectId: 'therapease-c2a4c',
    authDomain: 'therapease-c2a4c.firebaseapp.com',
    storageBucket: 'therapease-c2a4c.appspot.com',
    measurementId: 'G-6BB58YFQRQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4eUj1ACWMpyos66ChoLC76nVk8YFl-3g',
    appId: '1:744230371015:android:b7de1885581536e173c8e2',
    messagingSenderId: '744230371015',
    projectId: 'therapease-c2a4c',
    storageBucket: 'therapease-c2a4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4eUj1ACWMpyos66ChoLC76nVk8YFl-3g',
    appId: '1:744230371015:ios:1c0fc32c2187814473c8e2',
    messagingSenderId: '744230371015',
    projectId: 'therapease-c2a4c',
    storageBucket: 'therapease-c2a4c.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsF9sNONYBhigvm7dWyJJVM5Sy7oOk6RU',
    appId: '1:744230371015:ios:1c0fc32c2187814473c8e2',
    messagingSenderId: '744230371015',
    projectId: 'therapease-c2a4c',
    storageBucket: 'therapease-c2a4c.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4eUj1ACWMpyos66ChoLC76nVk8YFl-3g',
    appId: '1:744230371015:web:c4f48587fc180a7373c8e2',
    messagingSenderId: '744230371015',
    projectId: 'therapease-c2a4c',
    authDomain: 'therapease-c2a4c.firebaseapp.com',
    storageBucket: 'therapease-c2a4c.appspot.com',
    measurementId: 'G-LY209B71WH',
  );
}
