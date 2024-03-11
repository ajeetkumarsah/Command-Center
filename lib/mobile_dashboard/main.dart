import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_device/safe_device.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:command_centre/mobile_dashboard/firebase_options.dart';
import 'package:command_centre/mobile_dashboard/bindings/home_binding.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Some Notification Received');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'comandc-99a4a', options: DefaultFirebaseOptions.currentPlatform);
  await Future.delayed(const Duration(seconds: 2));
  // await FirebaseApi().initNotifications();
  await HomeBinding().dependencies();

  // await PushNotifications.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // var initializationSettingsAndroid =
  // const AndroidInitializationSettings('@mipmap/ic_launcher');
  Future<bool> securityCheck() async {
    bool isJailBroken = await SafeDevice.isJailBroken;
    bool isCanMockLocation = await SafeDevice.canMockLocation;
    bool isRealDevice = await SafeDevice.isRealDevice;
    bool isSafeDevice = await SafeDevice.isSafeDevice;

    if (isJailBroken || isCanMockLocation || !isRealDevice || !isSafeDevice) {
      return false;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      bool isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;
      bool isOnExternalStorage = await SafeDevice.isOnExternalStorage;

      if (isDevelopmentModeEnable || isOnExternalStorage) {
        return false;
      }
    }

    return true;
  }

  bool isSecure = await securityCheck();

  if (isSecure) {
    // You can show an error message, log the event, or simply terminate the app.
    // For simplicity, this example terminates the app.
    debugPrint(
        "Rooted device or emulator detected. The app cannot be installed.");
    Fluttertoast.showToast(
        msg: "Rooted device or emulator detected. The app cannot be installed.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return;
  }
  runApp(
    GetMaterialApp(
      title: "Command Center",
      initialRoute: AppPages.SPLASH_SCREEN,
      // home: const OnboardingScreen(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
  (error, stack) =>
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
}
