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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDNTjJ5ku2WdqOBzprf7HT6HBGJyqOz-V4',
    appId: '1:1073912253938:web:195190ad742157d67b2f6b',
    messagingSenderId: '1073912253938',
    projectId: 'chat-app-88c4a',
    authDomain: 'chat-app-88c4a.firebaseapp.com',
    storageBucket: 'chat-app-88c4a.firebasestorage.app',
    measurementId: 'G-ZLHF55S9DT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZgXaPRNp1GgBXtbZ4t0JuUTddSBqXntQ',
    appId: '1:1073912253938:android:e7ab07ab23b6162e7b2f6b',
    messagingSenderId: '1073912253938',
    projectId: 'chat-app-88c4a',
    storageBucket: 'chat-app-88c4a.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDNTjJ5ku2WdqOBzprf7HT6HBGJyqOz-V4',
    appId: '1:1073912253938:web:70592a53c748a0777b2f6b',
    messagingSenderId: '1073912253938',
    projectId: 'chat-app-88c4a',
    authDomain: 'chat-app-88c4a.firebaseapp.com',
    storageBucket: 'chat-app-88c4a.firebasestorage.app',
    measurementId: 'G-6PJKGEB290',
  );
}
