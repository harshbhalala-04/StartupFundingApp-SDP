// ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/screens/investors/investor_feed_screen.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:random_string/random_string.dart';

dynamic createLocalNotification({required Map<String, dynamic> message}) async {
  final Map<String, String> data = {};

  message.forEach((key, value) {
    data[key] = value.toString();
  });

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message['title'],
          body: message['message'],
          payload: data));
}

/// Converting Remote Notifcation To Local Notification
handleNetworkNotification(RemoteMessage message) {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message.notification!.title,
          body: message.notification!.body,
          payload: {}));
}

/// Will be called when the app is terminated
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await createLocalNotification(message: message.data);
}

dynamic initializeLocalNotification() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        importance: NotificationImportance.Max,
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.black,
        channelShowBadge: true,
        ledColor: Colors.white)
  ]);
}

dynamic handleNotificationRouting(
    {required Map<String, dynamic> message}) async {
  // final globalController = Get.put(GlobalController());
  switch (message['screen']) {
    case 'Investor_Feed_Screen':
      Get.to(InvestorHomeScreen());
      break;
    case 'Startup_Feed_Screen':
      Get.to(StartupHomeScreen());
      break;
    default:
  }
}
