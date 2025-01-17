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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCsNqHe_mMngyy8Rna1drV9akS4BXfVhl4',
    appId: '1:844071310077:web:82a9ac81cf33f2b4da6494',
    messagingSenderId: '844071310077',
    projectId: 'madina-pos',
    authDomain: 'madina-pos.firebaseapp.com',
    storageBucket: 'madina-pos.appspot.com',
    measurementId: 'G-K0L99VD2KN',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIFPVeLZL0YuviNN-op_Cgtvu_GiBn-h8',
    appId: '1:844071310077:ios:d5bf9274d2481aecda6494',
    messagingSenderId: '844071310077',
    projectId: 'madina-pos',
    storageBucket: 'madina-pos.appspot.com',
    iosBundleId: 'com.example.madinaPosSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsNqHe_mMngyy8Rna1drV9akS4BXfVhl4',
    appId: '1:844071310077:web:55baa3ff01447b59da6494',
    messagingSenderId: '844071310077',
    projectId: 'madina-pos',
    authDomain: 'madina-pos.firebaseapp.com',
    storageBucket: 'madina-pos.appspot.com',
    measurementId: 'G-MGD9WT9E7J',
  );
}
