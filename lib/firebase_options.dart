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
    apiKey: 'AIzaSyB9KSE32UP7-tHVtHZW0fFLuVq7ptdhsOM',
    appId: '1:655833124441:web:8633f4d7fecbb2a824ab48',
    messagingSenderId: '655833124441',
    projectId: 'ppl-agro',
    authDomain: 'ppl-agro.firebaseapp.com',
    databaseURL: 'https://ppl-agro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ppl-agro.appspot.com',
    measurementId: 'G-4ZWZ21RBWF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7X7ho4NR3vkqc1A0AxyKncCNjqRpQnvc',
    appId: '1:655833124441:android:671ab21fb7c42cd824ab48',
    messagingSenderId: '655833124441',
    projectId: 'ppl-agro',
    databaseURL: 'https://ppl-agro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ppl-agro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqt4q0lHZdT5wvjGpmF5tI56IdItMWHtA',
    appId: '1:655833124441:ios:b0c027ac7e3f444b24ab48',
    messagingSenderId: '655833124441',
    projectId: 'ppl-agro',
    databaseURL: 'https://ppl-agro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ppl-agro.appspot.com',
    iosBundleId: 'com.example.siopPplAgro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqt4q0lHZdT5wvjGpmF5tI56IdItMWHtA',
    appId: '1:655833124441:ios:90572b97ea9afe4e24ab48',
    messagingSenderId: '655833124441',
    projectId: 'ppl-agro',
    databaseURL: 'https://ppl-agro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ppl-agro.appspot.com',
    iosBundleId: 'com.example.siopPplAgro.RunnerTests',
  );
}
