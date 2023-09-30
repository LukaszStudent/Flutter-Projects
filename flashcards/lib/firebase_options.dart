// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCgBympTkwkQA2gc5PvlXBZp0oyPLoydFA',
    appId: '1:669480682779:web:c7649ba79ecb0a9a71ffbe',
    messagingSenderId: '669480682779',
    projectId: 'flashcards-2bd3d',
    authDomain: 'flashcards-2bd3d.firebaseapp.com',
    storageBucket: 'flashcards-2bd3d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHiuYmSwMfTrhIxO8SsTZPkIk5_YRSNBk',
    appId: '1:669480682779:android:463f6ca8cb9a31e571ffbe',
    messagingSenderId: '669480682779',
    projectId: 'flashcards-2bd3d',
    storageBucket: 'flashcards-2bd3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBE_CFthrzp3UMAZzBq8AYlnq2SjAvJL0E',
    appId: '1:669480682779:ios:ba31bc996efdc67471ffbe',
    messagingSenderId: '669480682779',
    projectId: 'flashcards-2bd3d',
    storageBucket: 'flashcards-2bd3d.appspot.com',
    iosBundleId: 'com.example.flashcards',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBE_CFthrzp3UMAZzBq8AYlnq2SjAvJL0E',
    appId: '1:669480682779:ios:504693dab4e2d49a71ffbe',
    messagingSenderId: '669480682779',
    projectId: 'flashcards-2bd3d',
    storageBucket: 'flashcards-2bd3d.appspot.com',
    iosBundleId: 'com.example.flashcards.RunnerTests',
  );
}