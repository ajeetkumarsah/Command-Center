// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
//
// String formatDate(DateTime date) => new DateFormat("dd-MM-yyyy").format(date);
//
// /// Returns the difference (in full days) between the provided date and today.
// int calculateDifference(DateTime date) {
//   DateTime now = DateTime.now();
//   return DateTime(date.year, date.month, date.day)
//       .difference(DateTime(now.year, now.month, now.day))
//       .inDays;
// }
// enum AnalyticsEvent {
//   catch_event,
//   http_error_event,
//   unknown_event,
// }
//
// class LoggerUtils{
//   static showToast(String title) {
//     Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: title);
//     Logger().wtf(title);
//   }
//
//   static firebaseAnalytics(AnalyticsEvent event, String title) {
//     FirebaseAnalytics.instance.logEvent(name: event.toString(), parameters: {"message": title});
//     Logger().wtf(title);
//   }
//
//   static toastWithAnalytics(AnalyticsEvent event, String title){
//     Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: title);
//     FirebaseAnalytics.instance.logEvent(name: event.toString(), parameters: {"message": title});
//     Logger().wtf(title);
//   }
//
//   static detailsToast(String title){
//     Fluttertoast.showToast(
//         msg: title,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.blueAccent,
//         textColor: Colors.white,
//         fontSize: 16.0);
//     Logger().wtf(title);
//   }
// }