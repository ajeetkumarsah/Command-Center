// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:command_centre/mobile_dashboard/utils/sec_helper/obfuscation.dart';
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: Obfuscation.decodeString('41497a615379415644553145697376665664334c42387646424937644f79457369706179615851'),
    appId: '1:966656788419:web:875cb09c977378a51c5f76',
    messagingSenderId: '966656788419',
    projectId: 'comandc-99a4a',
    authDomain: 'comandc-99a4a.firebaseapp.com',
    storageBucket: 'comandc-99a4a.appspot.com',
    measurementId: 'G-F3G4J9C5L2',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: Obfuscation.decodeString('41497a615379433237446f7049656e6c79562d455f42443767314c676b386d454a51616f556745'),
    appId: '1:966656788419:android:045e731bcc7b42961c5f76',
    messagingSenderId: '966656788419',
    projectId: 'comandc-99a4a',
    storageBucket: 'comandc-99a4a.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: Obfuscation.decodeString('41497a6153794150344364556437466e72676373705a7147525873716b6f677a6e674661536e6b'),
    appId: '1:966656788419:ios:4399c6a779fb3bd31c5f76',
    messagingSenderId: '966656788419',
    projectId: 'comandc-99a4a',
    storageBucket: 'comandc-99a4a.appspot.com',
    iosBundleId: 'com.commandcentre.command-centre',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: Obfuscation.decodeString('41497a6153794150344364556437466e72676373705a7147525873716b6f677a6e674661536e6b'),
    appId: '1:966656788419:ios:c1eee802c9ed66f11c5f76',
    messagingSenderId: '966656788419',
    projectId: 'comandc-99a4a',
    storageBucket: 'comandc-99a4a.appspot.com',
    iosBundleId: 'tranzita.pgMumbaiCommandCentreMobile.RunnerTests',
  );
}