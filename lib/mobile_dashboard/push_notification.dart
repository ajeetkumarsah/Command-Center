import 'dart:io';

import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;


class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future init() async{
    await _firebaseMessaging.requestPermission(
      alert : true,
      announcement : true,
      badge : true,
      carPlay : false,
      criticalAlert : false,
      provisional : false,
      sound : true,
    );
    final token = await _firebaseMessaging.getToken();
    SharedPreferences session = await SharedPreferences.getInstance();
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        await session.setString(AppConstants.FCMToken, token ?? '');
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          await session.setString(AppConstants.FCMToken, token ?? '');
        }
      }
    } else {
      await session.setString(AppConstants.FCMToken, token ?? '');
    }


    // globals.FCMToken = session.getString(AppConstants.FCMToken) ?? '';

    globals.FCMToken = session.getString(AppConstants.FCMToken) ?? '';
    print("Device Token : $token");
    // print("Device Token : ${globals.FCMToken}");
  }
}