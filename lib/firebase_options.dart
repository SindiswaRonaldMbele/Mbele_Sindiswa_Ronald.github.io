import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Run flutterfire configure for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVQ8gaeOInPYFEoW6PPQCUGVGrIgLvess',
    appId: '1:569980709567:web:741e8b24f81ce8f25a340a',
    messagingSenderId: '569980709567',
    projectId: 'profile-1e99b',
    authDomain: 'profile-1e99b.firebaseapp.com',
    storageBucket: 'profile-1e99b.firebasestorage.app',
    measurementId: 'G-YHHEZCTRYS',
  );

}