import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// ignore_for_file: constant_identifier_names

enum AnalyticsEvent {
  catch_event,
  http_error_event,
  unknown_event,
  data_refreash,
  selected_filter,
  selected_month,
  selected_switch,
  selected_trend_analysis,
  deep_dive_indiret_direct,
  deep_dive_selected_geo,
  deep_dive_selected_channel,
  deep_dive_selected_category,
  deep_dive_selected_trends,
  deep_dive_selected_all,
  retailing,
  fb,
  gp,
  coverage,
  logs,
  level_filter
}

class LoggerUtils {
  static showToast(String title) {
    Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: title);
    Logger().wtf(title);
  }

  static firebaseAnalytics(AnalyticsEvent event, String title) {
    FirebaseAnalytics.instance
        .logEvent(name: event.toString(), parameters: {"message": title});
    Logger().wtf(title);
  }

  static toastWithAnalytics(AnalyticsEvent event, String title) {
    Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: title);
    FirebaseAnalytics.instance
        .logEvent(name: event.toString(), parameters: {"message": title});
    Logger().wtf(title);
  }

  static detailsToast(String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    Logger().wtf(title);
  }
}
