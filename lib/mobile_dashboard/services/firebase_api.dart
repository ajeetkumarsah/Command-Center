import 'dart:async';
import 'dart:convert';
import '../utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  //
  debugPrint('Notification Title  ==> ${message.notification?.title}');
  debugPrint('Body  ==> ${message.notification?.body}');
  debugPrint('Payload  ==> ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      //
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title??''),
    //     content: Text(body??''),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           // await Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) => SecondScreen(payload),
    //           //   ),
    //           // );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  Future initLocalNotifications() async {
    //
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) {},
    );
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(
        android: android, iOS: initializationSettingsDarwin);

    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse: (message) {
      debugPrint('Local Notification:${message.payload}');
    });
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;

      if (notification != null) {
        if (notification.body != null) {
          _localNotification.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    _androidChannel.id,
                    _androidChannel.name,
                    channelDescription: _androidChannel.description,
                    icon: '@drawable/ic_launcher',
                  ),
                  iOS: const DarwinNotificationDetails(
                    presentAlert: true,
                    presentBadge: true,
                    presentSound: true,
                  )),
              payload: jsonEncode(event.toMap()));
        }
      }
    });
  }

  Future<void> initNotifications() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    await session.setString(AppConstants.FCMToken, fcmToken!);
    debugPrint('FCMToken  ==> $fcmToken');
    initPushNotifications();
    initLocalNotifications();
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
