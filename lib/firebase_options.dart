import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'Platform not supported',
        );
    }
  }

  static const FirebaseOptions web =
  FirebaseOptions(
    apiKey:
    'AIzaSyBHdR4VQh0Yp8qluXm25PnCPuYmyU5prfc',
    appId:
    '1:978403540460:web:47907af2466fdac785d4c9',
    messagingSenderId: '978403540460',
    projectId:
    'proyecto-vocacional-99d5f',
    authDomain:
    'proyecto-vocacional-99d5f.firebaseapp.com',
    storageBucket:
    'proyecto-vocacional-99d5f.firebasestorage.app',
  );

  static const FirebaseOptions android =
  FirebaseOptions(
    apiKey:
    'AIzaSyBHdR4VQh0Yp8qluXm25PnCPuYmyU5prfc',
    appId:
    '1:978403540460:web:47907af2466fdac785d4c9',
    messagingSenderId: '978403540460',
    projectId:
    'proyecto-vocacional-99d5f',
    storageBucket:
    'proyecto-vocacional-99d5f.firebasestorage.app',
  );
}