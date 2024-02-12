import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_device/safe_device.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:command_centre/mobile_dashboard/firebase_options.dart';
import 'package:command_centre/mobile_dashboard/services/firebase_api.dart';
import 'package:command_centre/mobile_dashboard/bindings/home_binding.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await HomeBinding().dependencies();
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
    return;
  }
  runApp(
    GetMaterialApp(
      title: "Command Center",
      initialRoute: AppPages.SPLASH_SCREEN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
