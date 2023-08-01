import 'package:flutter/material.dart';
import 'package:complicated_scheduler/home_page.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:isolate';

import 'package:complicated_scheduler/alarm_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
   // Instance of Flutternotification plugin
   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

}